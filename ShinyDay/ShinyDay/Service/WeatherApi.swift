//
//  WeatherApi.swift
//  ShinyDay
//
//  Created by yoonie on 2/22/25.
//

import UIKit



class WeatherApi {
    
    enum Path: String {
        case weather = "data/2.5/weather"
        case forecast = "data/2.5/forecast"
        case air_pollution = "data/2.5/air_pollution"
        case reverseGeocoding = "geo/1.0/reverse"
    }
    
    var summary: CurrentWeather?
    var forecastList = [ForecastData]()
    var detailInfo = [DetailInfo]()
    var copyright: String?
    
    let group = DispatchGroup()
    
    private func fetch<ParsingType: Codable>(path: Path, lat: Double, lon: Double, completion: @escaping (Result<ParsingType, Error>) -> ()) {
        guard var url = URL(string: "https://api.openweathermap.org/\(path.rawValue)") else {
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
                
                let feelsLike = DetailInfo(image: UIImage(systemName: "thermometer.variable.and.figure"),
                                           title: "체감온도",
                                           value: data.main.feelsLike.temperatureString)
                self.detailInfo.append(feelsLike)
                
                let humidity = DetailInfo(image: UIImage(systemName: "humidity"),
                                          title: "습도",
                                          value: "\(data.main.humidity)%")
                self.detailInfo.append(humidity)
                
                let pressure = DetailInfo(image: UIImage(systemName: "gauge.with.needle"),
                                          title: "기압",
                                          value: data.main.pressure.pressureStringWithoutUnit,
                                          description: "hPa")
                self.detailInfo.append(pressure)
                
                let visibility = DetailInfo(image: UIImage(systemName: "eye"), title: "가시거리", value: data.visibility.visibilityString, description: "km")
                self.detailInfo.append(visibility)
                
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
    
    func fetchLocation(lat: Double, lon: Double, completion: @escaping (Result<String, Error>) -> ()) {
        fetch(path: Path.reverseGeocoding, lat: lat, lon: lon) { (result: Result<[Location], Error>) in
            switch result {
            case .success(let locations):
                let cityName = locations.first?.name ?? ""
                completion(.success(cityName))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchRandomImage(city: String, completion: @escaping (Result<URL, Error>) -> ()) {
        guard var url = URL(string: "https://api.unsplash.com/photos/random") else {
            completion(.failure(ApiError.invalidUrl("invalid url")))
            return
        }
        
        if #available(iOS 16.0, *) {
            url.append(queryItems: [
                URLQueryItem(name: "query", value: "seoul"),
                URLQueryItem(name: "orientation", value: "portrait")
            ])
        } else {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = [
                URLQueryItem(name: "query", value: "seoul"),
                URLQueryItem(name: "orientation", value: "portrait")
            ]
            url = components?.url ?? url
        }
        
        var request = URLRequest(url: url)
        request.addValue(unsplashClientId, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(error))
                return
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
                let decodedData = try decoder.decode(BackgroundImage.self, from: data)
                self.copyright = "© \(decodedData.user.userName)"
                completion(.success(decodedData.urls.regular))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func downloadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> ()) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(error))
                return
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
            
            guard let image = UIImage(data: data) else {
                completion(.failure(ApiError.emptyData))
                return
            }
            
            completion(.success(image))
        }
        task.resume()
    }
    
    
}

