//
//  Forecast.swift
//  ShinyDay
//
//  Created by yoonie on 2/22/25.
//

import Foundation


public struct Forecast: Codable {
    public let cod: String
    public let message: Int
    public let cnt: Int
    
    public struct ListItem: Codable {
        public let dt: Double
        
        public struct Main: Codable {
            public let temp: Double
        }
        
        public let main: Main
        
        public struct Weather: Codable {
            public let description: String
            public let icon: String
        }
        
        public let weather: [Weather]
        
    }
    
    public let list: [ListItem]
}

public struct ForecastData {
    public let date: Date
    public let temperature: Double
    public let weatherStatus: String
    public let icon: String
    
    public init(date: Date, temperature: Double, weatherStatus: String, icon: String) {
        self.date = date
        self.temperature = temperature
        self.weatherStatus = weatherStatus
        self.icon = icon
    }
}
