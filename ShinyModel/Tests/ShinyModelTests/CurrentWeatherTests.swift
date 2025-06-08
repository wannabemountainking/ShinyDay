//
//  CurrentWeatherTests.swift
//  ShinyModel
//
//  Created by YoonieMac on 6/8/25.
//

import XCTest
@testable import ShinyModel

final class CurrentWeatherTests: DecodableTests<CurrentWeather> {

    override func setUpWithError() throws {
        jsonString = """
            {
                "coord": {
                    "lon": 127.0214,
                    "lat": 37.5714
                },
                "weather": [
                    {
                        "id": 803,
                        "main": "Clouds",
                        "description": "튼구름",
                        "icon": "04n"
                    }
                ],
                "base": "stations",
                "main": {
                    "temp": 24.96,
                    "feels_like": 25.31,
                    "temp_min": 22.94,
                    "temp_max": 24.96,
                    "pressure": 1008,
                    "humidity": 69,
                    "sea_level": 1008,
                    "grnd_level": 997
                },
                "visibility": 10000,
                "wind": {
                    "speed": 0.51,
                    "deg": 280
                },
                "clouds": {
                    "all": 75
                },
                "dt": 1749386061,
                "sys": {
                    "type": 1,
                    "id": 8096,
                    "country": "KR",
                    "sunrise": 1749327038,
                    "sunset": 1749379887
                },
                "timezone": 32400,
                "id": 6800746,
                "name": "Kwanghŭi-dong",
                "cod": 200
            }
            """
        try super.setUpWithError()
    }
}
