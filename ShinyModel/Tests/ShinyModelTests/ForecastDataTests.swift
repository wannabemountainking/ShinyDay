//
//  ForecastDataTests.swift
//  ShinyModel
//
//  Created by YoonieMac on 6/8/25.
//

import XCTest
@testable import ShinyModel

final class ForecastDataTests: XCTestCase {

    func testInit_setsProperValue() {
        // arrange
        let expectedDate = Date(timeIntervalSinceNow: Double.random(in: -10000...10000))
        let expectedTemperature = Double.random(in: -20...40)
        let expectedWeatherStatus = ["맑음", "흐림", "눈", "비"].randomElement()!
        let expectedIcon = UUID().uuidString
        // act
        let result = ForecastData(date: expectedDate, temperature: expectedTemperature, weatherStatus: expectedWeatherStatus, icon: expectedIcon)
        // assert
        XCTAssertEqual(expectedDate, result.date)
        XCTAssertEqual(expectedTemperature, result.temperature)
        XCTAssertEqual(expectedWeatherStatus, result.weatherStatus)
        XCTAssertEqual(expectedIcon, result.icon)
    }
}
