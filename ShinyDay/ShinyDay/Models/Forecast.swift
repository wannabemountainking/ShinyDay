//
//  Forecast.swift
//  ShinyDay
//
//  Created by yoonie on 2/22/25.
//

import Foundation


struct Forecast: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    
    struct ListItem: Codable {
        let dt: Double
        
        struct Main: Codable {
            let temp: Double
        }
        
        let main: Main
        
        struct Weather: Codable {
            let description: String
            let icon: String
        }
        
        let weather: [Weather]
    }
    
    let list: [ListItem]
}

struct ForecastData {
    let date: Date
    let temperature: Double
    let weatherStatus: String
    let icon: String
}
