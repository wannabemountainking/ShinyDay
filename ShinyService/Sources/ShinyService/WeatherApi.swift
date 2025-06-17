//
//  WeatherApi.swift
//  ShinyDay
//
//  Created by yoonie on 2/22/25.
//

import UIKit
import ShinyFormatter
import ShinyModel


/*
 테스트 관련
 웹서버로 요청을 보내서 응답을 받은 다음, 적절한 형태로 파싱을 하는 기능을 담당한 URLSession 객체를 테스트에 맞게 Mocking해야 함
 그리고 테스트용으로 JSON 데이터가 필요한데 이것을 제공하는 객체도 필요
 */

//URLSeesion을 테스트하기 위해 data(for:)를 오버라이딩해야 하는데 이것은 public(public은 모듈 외부에서 접근만 가능하고 오버리아딩 불가. -> open에서는 가능)이어서 이를 위해는 protocol을 사용해 접근 필요?
public protocol URLSessionType: AnyObject {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionType {}

public class WeatherApi: @unchecked Sendable {
    
    public var summary: CurrentWeather?
    public var forecastList = [ForecastData]()
    public var detailInfo = [DetailInfo]()
    public var copyright: String?
    
    let userDefaults: UserDefaults
    let session: URLSessionType
    
    public init(session: URLSessionType = URLSession.shared, userDefaults: UserDefaults = .standard) {
        self.session = session
        self.userDefaults = userDefaults
    }
    
    private func fetch<ParsingType: Codable>(endpoint: Endpoint, queryItems: [String: Any] = [:]) async throws -> ParsingType {
        let request = try endpoint.request(customQueryItems: queryItems)
        
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {throw ApiError.invalidResponse}
        guard httpResponse.statusCode == 200 else {throw ApiError.failed(httpResponse.statusCode)}
        
        return try JSONDecoder().decode(ParsingType.self, from: data)
    }
    
    public func fetch(lat: Double, lon: Double) async throws {
        
        // 빈 객체만 저장하고 나중에 실제 값을 채울 수 있다.
        async let weatherResponse: CurrentWeather = fetch(endpoint: Endpoint.weather(lat, lon, userDefaults))
        async let forecastResponse: Forecast = fetch(endpoint: .forecast(lat, lon, userDefaults))
        async let airPollutionResponse: AirPollution = fetch(endpoint: .air_pollution(lat, lon, userDefaults))
        
        let (weather, forecast, airPollution) = try await (weatherResponse, forecastResponse, airPollutionResponse)
        
        summary = weather
        if let data = summary {
            let feelsLike = DetailInfo(image: UIImage(systemName: "thermometer.variable.and.figure"),
                                       title: "체감온도",
                                       value: data.main.feelsLike.temperatureString)
            self.detailInfo.append(feelsLike)
            
            let humidity = DetailInfo(image: UIImage(systemName: "humidity"),
                                      title: "습도",
                                      value: "\(data.main.humidity)%")
            self.detailInfo.append(humidity)
            let pressure = DetailInfo(image: UIImage(systemName: "gauge.with.dots.needle.50percent"),
                                      title: "기압",
                                      value: data.main.pressure.pressureStringWithoutUnit,
                                      description: "hPa")
            self.detailInfo.append(pressure)
            let visibility = DetailInfo(image: UIImage(systemName: "eye"), title: "가시거리", value: data.visibility.visibilityString, description: "km")
            self.detailInfo.append(visibility)
        }
    
        self.forecastList = forecast.list.map {
            let date = Date(timeIntervalSince1970: TimeInterval($0.dt))
            let temp = $0.main.temp
            let status = $0.weather.first?.description ?? "알 수 없음"
            let icon = $0.weather.first?.icon ?? ""
            
            return ForecastData(date: date, temperature: temp, weatherStatus: status, icon: icon)
        }
            
        self.detailInfo.append(contentsOf: airPollution.infoList)
    }
    
    public func fetchLocation(lat: Double, lon: Double) async throws -> String {
        let locations: [Location] = try await fetch(endpoint: .reverseGeocoding(lat, lon))
        return locations.first?.name ?? ""

    }
    
    public func fetchRandomImage(city: String) async throws -> URL {
        let result: BackgroundImage = try await fetch(endpoint: .randomImage(city))
        self.copyright = "© \(result.user.userName)"
        return result.urls.regular
    }
    
    public func downloadImage(from url: URL) async throws -> UIImage {
        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad
        
        let (imageData, _) = try await session.data(for: request)
        
        guard let image = UIImage(data: imageData) else {throw ApiError.emptyData}
        return image
    }
    
//    let group = DispatchGroup()
    
//    private func fetch<ParsingType: Codable>(path: Path, lat: Double, lon: Double, completion: @escaping (Result<ParsingType, Error>) -> ()) {
//        guard var url = URL(string: "https://api.openweathermap.org/\(path.rawValue)") else {
//            completion(.failure(ApiError.invalidUrl(path.rawValue)))
//            return
//        }
//        
//        if #available(iOS 16.0, *) {
//            url.append(queryItems: [
//                URLQueryItem(name: "lat", value: "\(lat)"),
//                URLQueryItem(name: "lon", value: "\(lon)"),
//                URLQueryItem(name: "appid", value: apiKey),
//                URLQueryItem(name: "units", value: "metric"),
//                URLQueryItem(name: "lang", value: "kr")
//            ])
//        } else {
//            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
//            components?.queryItems = [
//                URLQueryItem(name: "lat", value: "\(lat)"),
//                URLQueryItem(name: "lon", value: "\(lon)"),
//                URLQueryItem(name: "appid", value: apiKey),
//                URLQueryItem(name: "units", value: "metric"),
//                URLQueryItem(name: "lang", value: "kr")
//            ]
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error {
//                completion(.failure(error))
//            }
//            
//            guard let httpResponse = response as? HTTPURLResponse else {
//                completion(.failure(ApiError.invalidResponse))
//                return
//            }
//            guard httpResponse.statusCode == 200 else {
//                completion(.failure(ApiError.failed(httpResponse.statusCode)))
//                return
//            }
//            
//            guard let data else {
//                completion(.failure(ApiError.emptyData))
//                return
//            }
//            
//            do {
//                let decoder = JSONDecoder()
//                let result = try decoder.decode(ParsingType.self, from: data)
//                completion(.success(result))
//            } catch {
//                completion(.failure(error))
//            }
//        }
//        
//        task.resume()
//    }
//    
//    func fetch(lat: Double, lon: Double, completion: @escaping () -> ()) {
//        group.enter()
//        fetch(path: Path.weather, lat: lat, lon: lon) { (result: Result<CurrentWeather, Error>) in
//            switch result {
//            case .success(let data):
//                self.summary = data
//                
//                let feelsLike = DetailInfo(image: UIImage(systemName: "thermometer.variable.and.figure"),
//                                           title: "체감온도",
//                                           value: data.main.feelsLike.temperatureString)
//                self.detailInfo.append(feelsLike)
//                
//                let humidity = DetailInfo(image: UIImage(systemName: "humidity"),
//                                          title: "습도",
//                                          value: "\(data.main.humidity)%")
//                self.detailInfo.append(humidity)
//                
//                let pressure = DetailInfo(image: UIImage(systemName: "gauge.with.needle"),
//                                          title: "기압",
//                                          value: data.main.pressure.pressureStringWithoutUnit,
//                                          description: "hPa")
//                self.detailInfo.append(pressure)
//                
//                let visibility = DetailInfo(image: UIImage(systemName: "eye"), title: "가시거리", value: data.visibility.visibilityString, description: "km")
//                self.detailInfo.append(visibility)
//                
//            case .failure(_):
//                self.summary = nil
//            }
//            self.group.leave()
//        }
//        
//        group.enter()
//        fetch(path: Path.forecast, lat: lat, lon: lat) { (result: Result<Forecast, Error>) in
//            switch result {
//            case .success(let data):
//                self.forecastList = data.list.map {
//                    let date = Date(timeIntervalSince1970: TimeInterval($0.dt))
//                    let temp = $0.main.temp
//                    let status = $0.weather.first?.description ?? "알 수 없음"
//                    let icon = $0.weather.first?.icon ?? "알 수 없음"
//                    
//                    return ForecastData(date: date, temperature: temp, weatherStatus: status, icon: icon)
//                }
//            case .failure(_):
//                self.forecastList = []
//            }
//            self.group.leave()
//        }
//        
//        group.enter()
//        fetch(path: Path.air_pollution, lat: lat, lon: lon) { (result: Result<AirPollution, Error>) in
//            switch result {
//            case .success(let data):
//                self.detailInfo.append(contentsOf: data.infoList)
//            case .failure(_):
//                self.detailInfo = []
//            }
//            self.group.leave()
//        }
//        
//        group.notify(queue: .main) {
//            completion()
//        }
//    }
//    
//    func fetchLocation(lat: Double, lon: Double, completion: @escaping (Result<String, Error>) -> ()) {
//        fetch(path: Path.reverseGeocoding, lat: lat, lon: lon) { (result: Result<[Location], Error>) in
//            switch result {
//            case .success(let locations):
//                let cityName = locations.first?.name ?? ""
//                completion(.success(cityName))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//    
//    func fetchRandomImage(city: String, completion: @escaping (Result<URL, Error>) -> ()) {
//        guard var url = URL(string: "https://api.unsplash.com/photos/random") else {
//            completion(.failure(ApiError.invalidUrl("invalid url")))
//            return
//        }
//        
//        if #available(iOS 16.0, *) {
//            url.append(queryItems: [
//                URLQueryItem(name: "query", value: "seoul"),
//                URLQueryItem(name: "orientation", value: "portrait")
//            ])
//        } else {
//            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
//            components?.queryItems = [
//                URLQueryItem(name: "query", value: "seoul"),
//                URLQueryItem(name: "orientation", value: "portrait")
//            ]
//            url = components?.url ?? url
//        }
//        
//        var request = URLRequest(url: url)
//        request.addValue(unsplashClientId, forHTTPHeaderField: "Authorization")
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error {
//                completion(.failure(error))
//                return
//            }
//            guard let httpResponse = response as? HTTPURLResponse else {
//                completion(.failure(ApiError.invalidResponse))
//                return
//            }
//            guard httpResponse.statusCode == 200 else {
//                completion(.failure(ApiError.failed(httpResponse.statusCode)))
//                return
//            }
//            guard let data else {
//                completion(.failure(ApiError.emptyData))
//                return
//            }
//            
//            do {
//                let decoder = JSONDecoder()
//                let decodedData = try decoder.decode(BackgroundImage.self, from: data)
//                self.copyright = "© \(decodedData.user.userName)"
//                completion(.success(decodedData.urls.regular))
//            } catch {
//                completion(.failure(error))
//            }
//        }
//        task.resume()
//    }
//    
//    func downloadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> ()) {
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error {
//                completion(.failure(error))
//                return
//            }
//            guard let httpResponse = response as? HTTPURLResponse else {
//                completion(.failure(ApiError.invalidResponse))
//                return
//            }
//            guard httpResponse.statusCode == 200 else {
//                completion(.failure(ApiError.failed(httpResponse.statusCode)))
//                return
//            }
//            guard let data else {
//                completion(.failure(ApiError.emptyData))
//                return
//            }
//            
//            guard let image = UIImage(data: data) else {
//                completion(.failure(ApiError.emptyData))
//                return
//            }
//            
//            completion(.success(image))
//        }
//        task.resume()
//    }
    
    
}

