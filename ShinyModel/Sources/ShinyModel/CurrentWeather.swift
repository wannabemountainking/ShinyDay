//
//  CurrentWeather.swift
//  ShinyDay
//
//  Created by yoonie on 2/22/25.
//

import Foundation

public struct CurrentWeather: Codable, Equatable {
    public struct Weather: Codable, Equatable {
        public let id: Int
        public let main: String
        public let description: String
        public let icon: String
    }
    
    public let weather: [Weather]
    
    public struct Main: Codable, Equatable {
        public enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure
            case humidity
        }
        
        public let temp: Double
        public let feelsLike: Double
        public let tempMin: Double
        public let tempMax: Double
        public let pressure: Int
        public let humidity: Int
    }
    
    public let main: Main
    public let visibility: Int
    public let dt: Int
}


