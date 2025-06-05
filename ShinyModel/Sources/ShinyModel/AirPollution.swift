//
//  AirPollution.swift
//  ShinyDay
//
//  Created by yoonie on 2/25/25.
//

import UIKit
import ShinyFormatter

public struct AirPollution: Codable {
    
    public struct Item: Codable {
        
        public struct Main: Codable {
            public let aqi: Int
        }
        
        public let main: Main
        
        public struct Components: Codable {
            public let o3: Double
            public let pm2_5: Double
            public let pm10: Double
        }
        
        public let components: Components
        
    }
    
    public let list: [Item]
}

public extension AirPollution {
    var infoList: [DetailInfo] {
        return [
            DetailInfo(image: UIImage(systemName: "aqi.medium"), title: "대기질", value: aqiString, description: "AQI - \(list.first?.main.aqi ?? 0)"),
            DetailInfo(image: UIImage(systemName: "aqi.medium"), title: "오존", value: o3String, description: "O₃ - µg/m³"),
            DetailInfo(image: UIImage(systemName: "aqi.medium"), title: "미세먼지", value: pm10String, description: "PM10 - µg/m³"),
            DetailInfo(image: UIImage(systemName: "aqi.medium"), title: "초미세먼지", value: pm25String, description: "PM2.5 - µg/m³")
        ]
    }
    
    var aqiString: String {
        guard let aqi = list.first?.main.aqi else {return "--"}
        switch aqi {
        case 1:
            return "좋음"
        case 2, 3:
            return "보통"
        case 4:
            return "나쁨"
        case 5:
            return "매우 나쁨"
        default:
            return "--"
        }
    }
    
    var o3String: String {
        guard let o3Value = list.first?.components.o3 else {return "--"}
        return o3Value.valueString
    }
    
    var pm10String: String {
        guard let pm10Value = list.first?.components.pm10 else {return "--"}
        return pm10Value.valueString
    }
    
    var pm25String: String {
        guard let pm25Value = list.first?.components.pm2_5 else {return "--"}
        return pm25Value.valueString
    }
}
