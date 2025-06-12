//
//  File.swift
//  ShinyService
//
//  Created by YoonieMac on 6/12/25.
//

import Foundation

public enum Endpoint {
    case weather
    case forecast
    case air_pollution
    case reverseGeocoding
    case randomImage
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
        case .weather, .forecast, .air_pollution, .reverseGeocoding:
            return [
                URLQueryItem(name: "units", value: "metric"),
                URLQueryItem(name: "lang", value: "kr"),
                URLQueryItem(name: "appid", value: apiKey)
            ]
        case .randomImage:
            return [
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
