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
        case air_pollution
    }
    
    var summary: CurrentWeather?
    var forecastList = [ForecastData]()
    var detailInfo = [DetailInfo]()
    
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
                URLQueryItem(name: "appid", value: apiKey),
                URLQueryItem(name: "units", value: "metric"),
                URLQueryItem(name: "lang", value: "kr")
            ])
        } else {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = [
                URLQueryItem(name: "lat", value: "\(lat)"),
                URLQueryItem(name: "lon", value: "\(lon)"),
                URLQueryItem(name: "appid", value: apiKey),
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
        
        task.resume()
    }
    
    func fetch(lat: Double, lon: Double, completion: @escaping () -> ()) {
        group.enter()
        fetch(path: Path.weather, lat: lat, lon: lon) { (result: Result<CurrentWeather, Error>) in
            switch result {
            case .success(let data):
                self.summary = data
            case .failure(_):
                self.summary = nil
            }
            self.group.leave()
        }
        
        group.enter()
        fetch(path: Path.forecast, lat: lat, lon: lat) { (result: Result<Forecast, Error>) in
            switch result {
            case .success(let data):
                self.forecastList = data.list.map {
                    let date = Date(timeIntervalSince1970: TimeInterval($0.dt))
                    let temp = $0.main.temp
                    let status = $0.weather.first?.description ?? "알 수 없음"
                    let icon = $0.weather.first?.icon ?? "알 수 없음"
                    
                    return ForecastData(date: date, temperature: temp, weatherStatus: status, icon: icon)
                }
            case .failure(_):
                self.forecastList = []
            }
            self.group.leave()
        }
        
        group.enter()
        fetch(path: Path.air_pollution, lat: lat, lon: lon) { (result: Result<AirPollution, Error>) in
            switch result {
            case .success(let data):
                self.detailInfo.append(contentsOf: data.infoList)
            case .failure(_):
                self.detailInfo = []
            }
            self.group.leave()
        }
        
        group.notify(queue: .main) {
            completion()
        }
    }
}
