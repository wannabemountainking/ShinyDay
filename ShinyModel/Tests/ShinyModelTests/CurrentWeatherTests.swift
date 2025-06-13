//
//  CurrentWeatherTests.swift
//  ShinyModel
//
//  Created by YoonieMac on 6/8/25.
//

import XCTest
@testable import ShinyModel
@testable import ShinyTestResource

final class CurrentWeatherTests: DecodableTests<CurrentWeather> {

    override func setUpWithError() throws {
        jsonString = ShinyTestResource.JsonString.currentWeather
        try super.setUpWithError()
    }
}
