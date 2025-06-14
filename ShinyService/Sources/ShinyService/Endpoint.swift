//
//  File.swift
//  ShinyService
//
//  Created by YoonieMac on 6/12/25.
//

import Foundation
@testable import ShinyModel
@testable import ShinyTestResource

public enum Endpoint {
    case weather(Double, Double, UserDefaults)
    case forecast(Double, Double, UserDefaults)
    case air_pollution(Double, Double, UserDefaults)
    case reverseGeocoding(Double, Double)
    case randomImage(String)
}

// url, api에서도 Endpoint를 사용하도록 타입 확장
extension Endpoint {
    var scheme: String {
        return "https"
    }
    // 현재 모두 동일 host 사용
    var host: String {
        switch self {
            case .weather, .forecast, .air_pollution, .reverseGeocoding:
                return "api.openweathermap.org"
            case .randomImage:
            return "api.unsplash.com"
            }
    }
    
    var path: String {
        switch self {
            case .weather:
                return "data/2.5/weather" // 10분
            case .forecast:
                return "data/2.5/forecast" // 3시간
            case .air_pollution:
                return "data/2.5/air_pollution" // 10분
            case .reverseGeocoding:
                return "geo/1.0/reverse" // 위치가 바뀔
            case .randomImage:
                return "photos/random"
        }
    }
    
    var httpMethod: String {
        switch self {
            case .weather, .forecast, .air_pollution, .reverseGeocoding:
                return "GET"
            case .randomImage:
                return "GET"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case let .weather(lat, lon, _),
                let .forecast(lat, lon, _),
                let .air_pollution(lat, lon, _),
                let .reverseGeocoding(lat, lon):
            return [
                URLQueryItem(name: "lat", value: "\(lat)"),
                URLQueryItem(name: "lon", value: "\(lon)"),
                URLQueryItem(name: "units", value: "metric"),
                URLQueryItem(name: "lang", value: "kr"),
                URLQueryItem(name: "appid", value: apiKey)
            ]
        case .randomImage(let query):
            return [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "orientation", value: "portrait")
            ]
        }
    }
    
    var httpHeaders: [String: String]? {
        switch self {
        case .weather, .forecast, .air_pollution, .reverseGeocoding:
            return nil
        case .randomImage:
            return ["Authorization": unsplashClientId]
        }
    }
    
    // cache만료 시간을 리턴하는 메서드 cacheExpirationInterval: TimeInterval?
    var cacheExpirationInterval: TimeInterval? {
        switch self {
        case .weather, .air_pollution:
            return 60 * 10
        case .forecast:
            return 60 * 60 * 3
        default:
            return nil
        }
    }
    
    //캐시 정책 리턴
    // URLRequest.CachePolicy.returnCacheDataElseLoad: 캐시에 데이터가 있으면 캐시를 사용하고 없으면 네트워크에서 데이터를 로드한다: 오프라인 모드 앱에서 자주 사용. 빠른 응답. 캐시가 있으면 절대 네트워크 쓰지 않음
    // URLRequest.CachePolicy.useProtocolCachePolicy: 서버의 응답헤더(Cache-Control, Expires 등)에 따라 캐시를 쓸지 네트워크 요청을 다시 보낼 지 결정. 일반적인 네트워크 요청에 사용됨
    var cachePolicy: URLRequest.CachePolicy {
        guard let cacheExpirationInterval else {
            return .useProtocolCachePolicy
        }
        
        switch self {
        case .weather(let lat, let lon, let userDefaults),
                .air_pollution(let lat, let lon, let userDefaults),
                .forecast(let lat, let lon, let userDefaults):
            let key = path.appending("\(lat)").appending("\(lon)")
            if let date = userDefaults.object(forKey: key) as? Date {
                if date.timeIntervalSinceNow >= -cacheExpirationInterval {
                    return .returnCacheDataElseLoad
                }
            }
            userDefaults.set(Date(), forKey: key)
        case .reverseGeocoding:
            return .returnCacheDataElseLoad
        default:
            break
        }
        
        return .useProtocolCachePolicy
    }
    
    var sampleJson: Data? {
        switch self {
        case .weather:
            return ShinyTestResource.JsonData.currentWeather
        case .forecast:
            return ShinyTestResource.JsonData.forecast
        case .air_pollution:
            return ShinyTestResource.JsonData.airPollution
        case .reverseGeocoding:
            return ShinyTestResource.JsonData.reverseGeocoding
        case .randomImage:
            return ShinyTestResource.JsonData.randomImage
        }
    }
    
    
    // 요청에 사용할 URLRequest를 만들어서 Header와 QueryItem을 채운 후, return
    func request(customHttpHeaders: [String: String] = [:], customQueryItems: [String: Any] = [:]) throws -> URLRequest {
        
        guard var url = URL(string: "\(scheme)://\(host)/\(path)") else {
            throw ApiError.invalidUrl(path)
        }
        
        var finalQueryItems = queryItems ?? []
        for item in customQueryItems {
            finalQueryItems.append(URLQueryItem(name: item.key, value: "\(item.value)"))
        }
        
        if #available(iOS 16, *) {
            url.append(queryItems: finalQueryItems)
        } else {
            // urlcomponent를 만들어서 다시 url 리턴
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = finalQueryItems
            url = components?.url ?? url
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.cachePolicy = cachePolicy
        
        if let httpHeaders {
            for item in httpHeaders {
                request.addValue(item.value, forHTTPHeaderField: item.key)
            }
        }
        
        for item in customHttpHeaders {
            request.addValue(item.value, forHTTPHeaderField: item.key)
        }
        return request
    }
    
    
}
