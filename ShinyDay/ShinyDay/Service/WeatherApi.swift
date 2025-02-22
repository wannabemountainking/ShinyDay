//
//  WeatherApi.swift
//  ShinyDay
//
//  Created by yoonie on 2/22/25.
//

import Foundation



class WeatherApi {
    
    enum Path: String {
        case weather
        case forecast
    }
    
    var summary: CurrentWeather?
    var forecast: Forecast?
    let group = DispatchGroup()
    
    private func fetch<ParsingType: Codable>(path: Path, lat: Double, lon: Double, completion: @escaping (Result<ParsingType, Error>) -> ()) {
        guard var url = URL(string: "https://api.openweathermap.org/data/2.5/\(path.rawValue)") else {
            completion(.failure(ApiError.invalidUrl(path.rawValue)))
            return
        }
        
        if #available(iOS 16.0, *) {
            url.append(queryItems: [
                URLQueryItem(name: "lat", value: "\(lat)"),
                URLQueryItem(name: "lon", value: "\(lon)"),
                URLQueryItem(name: "appid", value: "b806f37af8d3b35c2646a93ce82d5c3b"),
                URLQueryItem(name: "units", value: "metric"),
                URLQueryItem(name: "lang", value: "kr")
            ])
        } else {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = [
                URLQueryItem(name: "lat", value: "\(lat)"),
                URLQueryItem(name: "lon", value: "\(lon)"),
                URLQueryItem(name: "appid", value: "b806f37af8d3b35c2646a93ce82d5c3b"),
                URLQueryItem(name: "units", value: "metric"),
                URLQueryItem(name: "lang", value: "kr")
            ]
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(error))
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(ApiError.invalidResponse))
                return
            }
            guard httpResponse.statusCode == 200 else {
                completion(.failure(ApiError.failed(httpResponse.statusCode)))
                return
            }
            
            guard let data else {
                completion(.failure(ApiError.emptyData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(ParsingType.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func fetch(lat: Double, lon: Double, completion: @escaping () -> ()) {
        group.enter()
        fetch(path: Path.weather, lat: lat, lon: lon) { (result: Result<CurrentWeather, Error>) in
            switch result {
            case .success(let data):
                self.summary = data
            case .failure(let failure):
                self.summary = nil
            }
            self.group.leave()
        }
        
        group.enter()
        fetch(path: Path.forecast, lat: lat, lon: lat) { (result: Result<Forecast, Error>) in
            switch result {
            case .success(let data):
                self.forecast = data
            case .failure(let failure):
                self.forecast = nil
            }
            self.group.leave()
        }
        
        group.notify(queue: .main) {
            completion()
        }
    }
}
