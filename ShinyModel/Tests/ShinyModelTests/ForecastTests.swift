//
//  ForecastTests.swift
//  ShinyModel
//
//  Created by YoonieMac on 6/8/25.
//

import XCTest
@testable import ShinyModel

final class ForecastTests: DecodableTests<Forecast> {

    override func setUpWithError() throws {
        jsonString = """
            {
                "cod": "200",
                "message": 0,
                "cnt": 40,
                "list": [
                    {
                        "dt": 1749394800,
                        "main": {
                            "temp": 24.35,
                            "feels_like": 24.69,
                            "temp_min": 23.14,
                            "temp_max": 24.35,
                            "pressure": 1008,
                            "sea_level": 1008,
                            "grnd_level": 998,
                            "humidity": 71,
                            "temp_kf": 1.21
                        },
                        "weather": [
                            {
                                "id": 803,
                                "main": "Clouds",
                                "description": "튼구름",
                                "icon": "04n"
                            }
                        ],
                        "clouds": {
                            "all": 83
                        },
                        "wind": {
                            "speed": 1.96,
                            "deg": 216,
                            "gust": 2.66
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "n"
                        },
                        "dt_txt": "2025-06-08 15:00:00"
                    },
                    {
                        "dt": 1749405600,
                        "main": {
                            "temp": 22.52,
                            "feels_like": 22.94,
                            "temp_min": 21.3,
                            "temp_max": 22.52,
                            "pressure": 1009,
                            "sea_level": 1009,
                            "grnd_level": 997,
                            "humidity": 81,
                            "temp_kf": 1.22
                        },
                        "weather": [
                            {
                                "id": 804,
                                "main": "Clouds",
                                "description": "온흐림",
                                "icon": "04n"
                            }
                        ],
                        "clouds": {
                            "all": 91
                        },
                        "wind": {
                            "speed": 1.46,
                            "deg": 215,
                            "gust": 2.05
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "n"
                        },
                        "dt_txt": "2025-06-08 18:00:00"
                    },
                    {
                        "dt": 1749416400,
                        "main": {
                            "temp": 22.19,
                            "feels_like": 22.5,
                            "temp_min": 22.19,
                            "temp_max": 22.19,
                            "pressure": 1009,
                            "sea_level": 1009,
                            "grnd_level": 997,
                            "humidity": 78,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 804,
                                "main": "Clouds",
                                "description": "온흐림",
                                "icon": "04d"
                            }
                        ],
                        "clouds": {
                            "all": 100
                        },
                        "wind": {
                            "speed": 1.24,
                            "deg": 186,
                            "gust": 2.17
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "d"
                        },
                        "dt_txt": "2025-06-08 21:00:00"
                    },
                    {
                        "dt": 1749427200,
                        "main": {
                            "temp": 24.23,
                            "feels_like": 24.41,
                            "temp_min": 24.23,
                            "temp_max": 24.23,
                            "pressure": 1009,
                            "sea_level": 1009,
                            "grnd_level": 997,
                            "humidity": 65,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 804,
                                "main": "Clouds",
                                "description": "온흐림",
                                "icon": "04d"
                            }
                        ],
                        "clouds": {
                            "all": 100
                        },
                        "wind": {
                            "speed": 1.48,
                            "deg": 164,
                            "gust": 1.82
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "d"
                        },
                        "dt_txt": "2025-06-09 00:00:00"
                    },
                    {
                        "dt": 1749438000,
                        "main": {
                            "temp": 29.68,
                            "feels_like": 29.12,
                            "temp_min": 29.68,
                            "temp_max": 29.68,
                            "pressure": 1007,
                            "sea_level": 1007,
                            "grnd_level": 996,
                            "humidity": 38,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 804,
                                "main": "Clouds",
                                "description": "온흐림",
                                "icon": "04d"
                            }
                        ],
                        "clouds": {
                            "all": 97
                        },
                        "wind": {
                            "speed": 1.28,
                            "deg": 180,
                            "gust": 1.41
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "d"
                        },
                        "dt_txt": "2025-06-09 03:00:00"
                    },
                    {
                        "dt": 1749448800,
                        "main": {
                            "temp": 31.59,
                            "feels_like": 30.07,
                            "temp_min": 31.59,
                            "temp_max": 31.59,
                            "pressure": 1006,
                            "sea_level": 1006,
                            "grnd_level": 994,
                            "humidity": 27,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 803,
                                "main": "Clouds",
                                "description": "튼구름",
                                "icon": "04d"
                            }
                        ],
                        "clouds": {
                            "all": 80
                        },
                        "wind": {
                            "speed": 3.99,
                            "deg": 248,
                            "gust": 2.65
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "d"
                        },
                        "dt_txt": "2025-06-09 06:00:00"
                    },
                    {
                        "dt": 1749459600,
                        "main": {
                            "temp": 28.1,
                            "feels_like": 27.37,
                            "temp_min": 28.1,
                            "temp_max": 28.1,
                            "pressure": 1005,
                            "sea_level": 1005,
                            "grnd_level": 994,
                            "humidity": 34,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 804,
                                "main": "Clouds",
                                "description": "온흐림",
                                "icon": "04d"
                            }
                        ],
                        "clouds": {
                            "all": 97
                        },
                        "wind": {
                            "speed": 3.87,
                            "deg": 260,
                            "gust": 3.49
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "d"
                        },
                        "dt_txt": "2025-06-09 09:00:00"
                    },
                    {
                        "dt": 1749470400,
                        "main": {
                            "temp": 24.05,
                            "feels_like": 23.71,
                            "temp_min": 24.05,
                            "temp_max": 24.05,
                            "pressure": 1007,
                            "sea_level": 1007,
                            "grnd_level": 995,
                            "humidity": 46,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 802,
                                "main": "Clouds",
                                "description": "구름조금",
                                "icon": "03n"
                            }
                        ],
                        "clouds": {
                            "all": 50
                        },
                        "wind": {
                            "speed": 1.92,
                            "deg": 246,
                            "gust": 2.56
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "n"
                        },
                        "dt_txt": "2025-06-09 12:00:00"
                    },
                    {
                        "dt": 1749481200,
                        "main": {
                            "temp": 21.95,
                            "feels_like": 21.69,
                            "temp_min": 21.95,
                            "temp_max": 21.95,
                            "pressure": 1008,
                            "sea_level": 1008,
                            "grnd_level": 997,
                            "humidity": 57,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 802,
                                "main": "Clouds",
                                "description": "구름조금",
                                "icon": "03n"
                            }
                        ],
                        "clouds": {
                            "all": 50
                        },
                        "wind": {
                            "speed": 1.71,
                            "deg": 236,
                            "gust": 2.97
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "n"
                        },
                        "dt_txt": "2025-06-09 15:00:00"
                    },
                    {
                        "dt": 1749492000,
                        "main": {
                            "temp": 20.43,
                            "feels_like": 20.54,
                            "temp_min": 20.43,
                            "temp_max": 20.43,
                            "pressure": 1008,
                            "sea_level": 1008,
                            "grnd_level": 997,
                            "humidity": 77,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 803,
                                "main": "Clouds",
                                "description": "튼구름",
                                "icon": "04n"
                            }
                        ],
                        "clouds": {
                            "all": 76
                        },
                        "wind": {
                            "speed": 1.09,
                            "deg": 256,
                            "gust": 1.94
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "n"
                        },
                        "dt_txt": "2025-06-09 18:00:00"
                    },
                    {
                        "dt": 1749502800,
                        "main": {
                            "temp": 20.71,
                            "feels_like": 20.9,
                            "temp_min": 20.71,
                            "temp_max": 20.71,
                            "pressure": 1007,
                            "sea_level": 1007,
                            "grnd_level": 996,
                            "humidity": 79,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 804,
                                "main": "Clouds",
                                "description": "온흐림",
                                "icon": "04d"
                            }
                        ],
                        "clouds": {
                            "all": 100
                        },
                        "wind": {
                            "speed": 0.56,
                            "deg": 246,
                            "gust": 1.21
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "d"
                        },
                        "dt_txt": "2025-06-09 21:00:00"
                    },
                    {
                        "dt": 1749513600,
                        "main": {
                            "temp": 23.79,
                            "feels_like": 24.03,
                            "temp_min": 23.79,
                            "temp_max": 23.79,
                            "pressure": 1007,
                            "sea_level": 1007,
                            "grnd_level": 996,
                            "humidity": 69,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 804,
                                "main": "Clouds",
                                "description": "온흐림",
                                "icon": "04d"
                            }
                        ],
                        "clouds": {
                            "all": 94
                        },
                        "wind": {
                            "speed": 3.09,
                            "deg": 248,
                            "gust": 4.81
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "d"
                        },
                        "dt_txt": "2025-06-10 00:00:00"
                    },
                    {
                        "dt": 1749524400,
                        "main": {
                            "temp": 25.92,
                            "feels_like": 26.06,
                            "temp_min": 25.92,
                            "temp_max": 25.92,
                            "pressure": 1007,
                            "sea_level": 1007,
                            "grnd_level": 996,
                            "humidity": 57,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 804,
                                "main": "Clouds",
                                "description": "온흐림",
                                "icon": "04d"
                            }
                        ],
                        "clouds": {
                            "all": 98
                        },
                        "wind": {
                            "speed": 5.49,
                            "deg": 250,
                            "gust": 7.59
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "d"
                        },
                        "dt_txt": "2025-06-10 03:00:00"
                    },
                    {
                        "dt": 1749535200,
                        "main": {
                            "temp": 24.87,
                            "feels_like": 25.01,
                            "temp_min": 24.87,
                            "temp_max": 24.87,
                            "pressure": 1006,
                            "sea_level": 1006,
                            "grnd_level": 995,
                            "humidity": 61,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 804,
                                "main": "Clouds",
                                "description": "온흐림",
                                "icon": "04d"
                            }
                        ],
                        "clouds": {
                            "all": 99
                        },
                        "wind": {
                            "speed": 5.39,
                            "deg": 249,
                            "gust": 6.84
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "d"
                        },
                        "dt_txt": "2025-06-10 06:00:00"
                    },
                    {
                        "dt": 1749546000,
                        "main": {
                            "temp": 23.41,
                            "feels_like": 23.24,
                            "temp_min": 23.41,
                            "temp_max": 23.41,
                            "pressure": 1007,
                            "sea_level": 1007,
                            "grnd_level": 995,
                            "humidity": 55,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 804,
                                "main": "Clouds",
                                "description": "온흐림",
                                "icon": "04d"
                            }
                        ],
                        "clouds": {
                            "all": 100
                        },
                        "wind": {
                            "speed": 5.02,
                            "deg": 244,
                            "gust": 7.4
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "d"
                        },
                        "dt_txt": "2025-06-10 09:00:00"
                    },
                    {
                        "dt": 1749556800,
                        "main": {
                            "temp": 21.69,
                            "feels_like": 21.19,
                            "temp_min": 21.69,
                            "temp_max": 21.69,
                            "pressure": 1009,
                            "sea_level": 1009,
                            "grnd_level": 997,
                            "humidity": 49,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 804,
                                "main": "Clouds",
                                "description": "온흐림",
                                "icon": "04n"
                            }
                        ],
                        "clouds": {
                            "all": 100
                        },
                        "wind": {
                            "speed": 3.41,
                            "deg": 288,
                            "gust": 7.12
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "n"
                        },
                        "dt_txt": "2025-06-10 12:00:00"
                    },
                    {
                        "dt": 1749567600,
                        "main": {
                            "temp": 19.98,
                            "feels_like": 19.47,
                            "temp_min": 19.98,
                            "temp_max": 19.98,
                            "pressure": 1010,
                            "sea_level": 1010,
                            "grnd_level": 998,
                            "humidity": 55,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 804,
                                "main": "Clouds",
                                "description": "온흐림",
                                "icon": "04n"
                            }
                        ],
                        "clouds": {
                            "all": 93
                        },
                        "wind": {
                            "speed": 2.15,
                            "deg": 269,
                            "gust": 7.13
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "n"
                        },
                        "dt_txt": "2025-06-10 15:00:00"
                    },
                    {
                        "dt": 1749578400,
                        "main": {
                            "temp": 18.51,
                            "feels_like": 18.04,
                            "temp_min": 18.51,
                            "temp_max": 18.51,
                            "pressure": 1010,
                            "sea_level": 1010,
                            "grnd_level": 998,
                            "humidity": 62,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 803,
                                "main": "Clouds",
                                "description": "튼구름",
                                "icon": "04n"
                            }
                        ],
                        "clouds": {
                            "all": 78
                        },
                        "wind": {
                            "speed": 1.19,
                            "deg": 250,
                            "gust": 1.28
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "n"
                        },
                        "dt_txt": "2025-06-10 18:00:00"
                    },
                    {
                        "dt": 1749589200,
                        "main": {
                            "temp": 18.29,
                            "feels_like": 17.79,
                            "temp_min": 18.29,
                            "temp_max": 18.29,
                            "pressure": 1011,
                            "sea_level": 1011,
                            "grnd_level": 1000,
                            "humidity": 62,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 800,
                                "main": "Clear",
                                "description": "맑음",
                                "icon": "01d"
                            }
                        ],
                        "clouds": {
                            "all": 0
                        },
                        "wind": {
                            "speed": 1.37,
                            "deg": 239,
                            "gust": 2.2
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "d"
                        },
                        "dt_txt": "2025-06-10 21:00:00"
                    },
                    {
                        "dt": 1749600000,
                        "main": {
                            "temp": 23.68,
                            "feels_like": 23.12,
                            "temp_min": 23.68,
                            "temp_max": 23.68,
                            "pressure": 1012,
                            "sea_level": 1012,
                            "grnd_level": 1001,
                            "humidity": 39,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 800,
                                "main": "Clear",
                                "description": "맑음",
                                "icon": "01d"
                            }
                        ],
                        "clouds": {
                            "all": 0
                        },
                        "wind": {
                            "speed": 4.81,
                            "deg": 307,
                            "gust": 10.49
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "d"
                        },
                        "dt_txt": "2025-06-11 00:00:00"
                    },
                    {
                        "dt": 1749610800,
                        "main": {
                            "temp": 27.43,
                            "feels_like": 26.7,
                            "temp_min": 27.43,
                            "temp_max": 27.43,
                            "pressure": 1011,
                            "sea_level": 1011,
                            "grnd_level": 1000,
                            "humidity": 30,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 800,
                                "main": "Clear",
                                "description": "맑음",
                                "icon": "01d"
                            }
                        ],
                        "clouds": {
                            "all": 2
                        },
                        "wind": {
                            "speed": 5.79,
                            "deg": 319,
                            "gust": 9.4
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "d"
                        },
                        "dt_txt": "2025-06-11 03:00:00"
                    },
                    {
                        "dt": 1749621600,
                        "main": {
                            "temp": 29.35,
                            "feels_like": 27.9,
                            "temp_min": 29.35,
                            "temp_max": 29.35,
                            "pressure": 1010,
                            "sea_level": 1010,
                            "grnd_level": 999,
                            "humidity": 25,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 801,
                                "main": "Clouds",
                                "description": "약간의 구름이 낀 하늘",
                                "icon": "02d"
                            }
                        ],
                        "clouds": {
                            "all": 20
                        },
                        "wind": {
                            "speed": 5.73,
                            "deg": 300,
                            "gust": 8.32
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "d"
                        },
                        "dt_txt": "2025-06-11 06:00:00"
                    },
                    {
                        "dt": 1749632400,
                        "main": {
                            "temp": 27.05,
                            "feels_like": 26.62,
                            "temp_min": 27.05,
                            "temp_max": 27.05,
                            "pressure": 1011,
                            "sea_level": 1011,
                            "grnd_level": 999,
                            "humidity": 34,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 800,
                                "main": "Clear",
                                "description": "맑음",
                                "icon": "01d"
                            }
                        ],
                        "clouds": {
                            "all": 9
                        },
                        "wind": {
                            "speed": 3.52,
                            "deg": 280,
                            "gust": 5.32
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "d"
                        },
                        "dt_txt": "2025-06-11 09:00:00"
                    },
                    {
                        "dt": 1749643200,
                        "main": {
                            "temp": 23.97,
                            "feels_like": 23.6,
                            "temp_min": 23.97,
                            "temp_max": 23.97,
                            "pressure": 1013,
                            "sea_level": 1013,
                            "grnd_level": 1001,
                            "humidity": 45,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 803,
                                "main": "Clouds",
                                "description": "튼구름",
                                "icon": "04n"
                            }
                        ],
                        "clouds": {
                            "all": 52
                        },
                        "wind": {
                            "speed": 2.17,
                            "deg": 214,
                            "gust": 3.29
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "n"
                        },
                        "dt_txt": "2025-06-11 12:00:00"
                    },
                    {
                        "dt": 1749654000,
                        "main": {
                            "temp": 22.68,
                            "feels_like": 22.34,
                            "temp_min": 22.68,
                            "temp_max": 22.68,
                            "pressure": 1013,
                            "sea_level": 1013,
                            "grnd_level": 1002,
                            "humidity": 51,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 804,
                                "main": "Clouds",
                                "description": "온흐림",
                                "icon": "04n"
                            }
                        ],
                        "clouds": {
                            "all": 100
                        },
                        "wind": {
                            "speed": 0.51,
                            "deg": 273,
                            "gust": 0.47
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "n"
                        },
                        "dt_txt": "2025-06-11 15:00:00"
                    },
                    {
                        "dt": 1749664800,
                        "main": {
                            "temp": 21.3,
                            "feels_like": 20.95,
                            "temp_min": 21.3,
                            "temp_max": 21.3,
                            "pressure": 1014,
                            "sea_level": 1014,
                            "grnd_level": 1002,
                            "humidity": 56,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 804,
                                "main": "Clouds",
                                "description": "온흐림",
                                "icon": "04n"
                            }
                        ],
                        "clouds": {
                            "all": 99
                        },
                        "wind": {
                            "speed": 0.2,
                            "deg": 169,
                            "gust": 0.32
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "n"
                        },
                        "dt_txt": "2025-06-11 18:00:00"
                    },
                    {
                        "dt": 1749675600,
                        "main": {
                            "temp": 20.62,
                            "feels_like": 20.25,
                            "temp_min": 20.62,
                            "temp_max": 20.62,
                            "pressure": 1015,
                            "sea_level": 1015,
                            "grnd_level": 1003,
                            "humidity": 58,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 804,
                                "main": "Clouds",
                                "description": "온흐림",
                                "icon": "04d"
                            }
                        ],
                        "clouds": {
                            "all": 98
                        },
                        "wind": {
                            "speed": 1,
                            "deg": 98,
                            "gust": 1.17
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "d"
                        },
                        "dt_txt": "2025-06-11 21:00:00"
                    },
                    {
                        "dt": 1749686400,
                        "main": {
                            "temp": 24.35,
                            "feels_like": 23.99,
                            "temp_min": 24.35,
                            "temp_max": 24.35,
                            "pressure": 1015,
                            "sea_level": 1015,
                            "grnd_level": 1003,
                            "humidity": 44,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 804,
                                "main": "Clouds",
                                "description": "온흐림",
                                "icon": "04d"
                            }
                        ],
                        "clouds": {
                            "all": 100
                        },
                        "wind": {
                            "speed": 1.01,
                            "deg": 87,
                            "gust": 1.02
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "d"
                        },
                        "dt_txt": "2025-06-12 00:00:00"
                    },
                    {
                        "dt": 1749697200,
                        "main": {
                            "temp": 29.9,
                            "feels_like": 28.66,
                            "temp_min": 29.9,
                            "temp_max": 29.9,
                            "pressure": 1014,
                            "sea_level": 1014,
                            "grnd_level": 1002,
                            "humidity": 30,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 804,
                                "main": "Clouds",
                                "description": "온흐림",
                                "icon": "04d"
                            }
                        ],
                        "clouds": {
                            "all": 100
                        },
                        "wind": {
                            "speed": 0.96,
                            "deg": 130,
                            "gust": 1.48
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "d"
                        },
                        "dt_txt": "2025-06-12 03:00:00"
                    },
                    {
                        "dt": 1749708000,
                        "main": {
                            "temp": 31.65,
                            "feels_like": 29.97,
                            "temp_min": 31.65,
                            "temp_max": 31.65,
                            "pressure": 1012,
                            "sea_level": 1012,
                            "grnd_level": 1001,
                            "humidity": 25,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 804,
                                "main": "Clouds",
                                "description": "온흐림",
                                "icon": "04d"
                            }
                        ],
                        "clouds": {
                            "all": 97
                        },
                        "wind": {
                            "speed": 2.14,
                            "deg": 192,
                            "gust": 2.05
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "d"
                        },
                        "dt_txt": "2025-06-12 06:00:00"
                    },
                    {
                        "dt": 1749718800,
                        "main": {
                            "temp": 29.66,
                            "feels_like": 28.44,
                            "temp_min": 29.66,
                            "temp_max": 29.66,
                            "pressure": 1013,
                            "sea_level": 1013,
                            "grnd_level": 1001,
                            "humidity": 30,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 804,
                                "main": "Clouds",
                                "description": "온흐림",
                                "icon": "04d"
                            }
                        ],
                        "clouds": {
                            "all": 100
                        },
                        "wind": {
                            "speed": 2.91,
                            "deg": 236,
                            "gust": 2.75
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "d"
                        },
                        "dt_txt": "2025-06-12 09:00:00"
                    },
                    {
                        "dt": 1749729600,
                        "main": {
                            "temp": 26.39,
                            "feels_like": 26.39,
                            "temp_min": 26.39,
                            "temp_max": 26.39,
                            "pressure": 1014,
                            "sea_level": 1014,
                            "grnd_level": 1002,
                            "humidity": 38,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 804,
                                "main": "Clouds",
                                "description": "온흐림",
                                "icon": "04n"
                            }
                        ],
                        "clouds": {
                            "all": 99
                        },
                        "wind": {
                            "speed": 1.43,
                            "deg": 270,
                            "gust": 1.97
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "n"
                        },
                        "dt_txt": "2025-06-12 12:00:00"
                    },
                    {
                        "dt": 1749740400,
                        "main": {
                            "temp": 23.96,
                            "feels_like": 23.59,
                            "temp_min": 23.96,
                            "temp_max": 23.96,
                            "pressure": 1015,
                            "sea_level": 1015,
                            "grnd_level": 1003,
                            "humidity": 45,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 804,
                                "main": "Clouds",
                                "description": "온흐림",
                                "icon": "04n"
                            }
                        ],
                        "clouds": {
                            "all": 95
                        },
                        "wind": {
                            "speed": 1.95,
                            "deg": 234,
                            "gust": 2.82
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "n"
                        },
                        "dt_txt": "2025-06-12 15:00:00"
                    },
                    {
                        "dt": 1749751200,
                        "main": {
                            "temp": 21.57,
                            "feels_like": 21.22,
                            "temp_min": 21.57,
                            "temp_max": 21.57,
                            "pressure": 1015,
                            "sea_level": 1015,
                            "grnd_level": 1004,
                            "humidity": 55,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 802,
                                "main": "Clouds",
                                "description": "구름조금",
                                "icon": "03n"
                            }
                        ],
                        "clouds": {
                            "all": 48
                        },
                        "wind": {
                            "speed": 1.72,
                            "deg": 255,
                            "gust": 2.95
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "n"
                        },
                        "dt_txt": "2025-06-12 18:00:00"
                    },
                    {
                        "dt": 1749762000,
                        "main": {
                            "temp": 20.83,
                            "feels_like": 20.46,
                            "temp_min": 20.83,
                            "temp_max": 20.83,
                            "pressure": 1015,
                            "sea_level": 1015,
                            "grnd_level": 1004,
                            "humidity": 57,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 800,
                                "main": "Clear",
                                "description": "맑음",
                                "icon": "01d"
                            }
                        ],
                        "clouds": {
                            "all": 3
                        },
                        "wind": {
                            "speed": 0.71,
                            "deg": 46,
                            "gust": 1.1
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "d"
                        },
                        "dt_txt": "2025-06-12 21:00:00"
                    },
                    {
                        "dt": 1749772800,
                        "main": {
                            "temp": 25.34,
                            "feels_like": 25.03,
                            "temp_min": 25.34,
                            "temp_max": 25.34,
                            "pressure": 1015,
                            "sea_level": 1015,
                            "grnd_level": 1004,
                            "humidity": 42,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 803,
                                "main": "Clouds",
                                "description": "튼구름",
                                "icon": "04d"
                            }
                        ],
                        "clouds": {
                            "all": 52
                        },
                        "wind": {
                            "speed": 1.21,
                            "deg": 199,
                            "gust": 1.44
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "d"
                        },
                        "dt_txt": "2025-06-13 00:00:00"
                    },
                    {
                        "dt": 1749783600,
                        "main": {
                            "temp": 30,
                            "feels_like": 28.91,
                            "temp_min": 30,
                            "temp_max": 30,
                            "pressure": 1014,
                            "sea_level": 1014,
                            "grnd_level": 1002,
                            "humidity": 32,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 804,
                                "main": "Clouds",
                                "description": "온흐림",
                                "icon": "04d"
                            }
                        ],
                        "clouds": {
                            "all": 100
                        },
                        "wind": {
                            "speed": 0.68,
                            "deg": 256,
                            "gust": 0.6
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "d"
                        },
                        "dt_txt": "2025-06-13 03:00:00"
                    },
                    {
                        "dt": 1749794400,
                        "main": {
                            "temp": 30.68,
                            "feels_like": 29.25,
                            "temp_min": 30.68,
                            "temp_max": 30.68,
                            "pressure": 1012,
                            "sea_level": 1012,
                            "grnd_level": 1000,
                            "humidity": 28,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 804,
                                "main": "Clouds",
                                "description": "온흐림",
                                "icon": "04d"
                            }
                        ],
                        "clouds": {
                            "all": 100
                        },
                        "wind": {
                            "speed": 2.94,
                            "deg": 234,
                            "gust": 2.33
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "d"
                        },
                        "dt_txt": "2025-06-13 06:00:00"
                    },
                    {
                        "dt": 1749805200,
                        "main": {
                            "temp": 29.05,
                            "feels_like": 28.17,
                            "temp_min": 29.05,
                            "temp_max": 29.05,
                            "pressure": 1011,
                            "sea_level": 1011,
                            "grnd_level": 1000,
                            "humidity": 34,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 804,
                                "main": "Clouds",
                                "description": "온흐림",
                                "icon": "04d"
                            }
                        ],
                        "clouds": {
                            "all": 100
                        },
                        "wind": {
                            "speed": 4,
                            "deg": 243,
                            "gust": 3.48
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "d"
                        },
                        "dt_txt": "2025-06-13 09:00:00"
                    },
                    {
                        "dt": 1749816000,
                        "main": {
                            "temp": 25.11,
                            "feels_like": 24.93,
                            "temp_min": 25.11,
                            "temp_max": 25.11,
                            "pressure": 1013,
                            "sea_level": 1013,
                            "grnd_level": 1001,
                            "humidity": 48,
                            "temp_kf": 0
                        },
                        "weather": [
                            {
                                "id": 804,
                                "main": "Clouds",
                                "description": "온흐림",
                                "icon": "04n"
                            }
                        ],
                        "clouds": {
                            "all": 100
                        },
                        "wind": {
                            "speed": 2.66,
                            "deg": 255,
                            "gust": 3.76
                        },
                        "visibility": 10000,
                        "pop": 0,
                        "sys": {
                            "pod": "n"
                        },
                        "dt_txt": "2025-06-13 12:00:00"
                    }
                ],
                "city": {
                    "id": 6800746,
                    "name": "Kwanghŭi-dong",
                    "coord": {
                        "lat": 37.5714,
                        "lon": 127.0214
                    },
                    "country": "KR",
                    "population": 2000,
                    "timezone": 32400,
                    "sunrise": 1749327038,
                    "sunset": 1749379887
                }
            }
            """
        try super.setUpWithError()
    }
}
