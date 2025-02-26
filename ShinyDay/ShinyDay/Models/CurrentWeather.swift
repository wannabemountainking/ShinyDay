//
//  CurrentWeather.swift
//  ShinyDay
//
//  Created by yoonie on 2/22/25.
//

import Foundation

struct CurrentWeather: Codable {
    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    let weather: [Weather]
    
    struct Main: Codable {
        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure
            case humidity
        }
        
        let temp: Double
        let feelsLike: Double
        let tempMin: Double
        let tempMax: Double
        let pressure: Int
        let humidity: Int
    }
    
    let main: Main
    let visibility: Int
    let dt: Int
}


