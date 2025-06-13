//
//  ForecastTests.swift
//  ShinyModel
//
//  Created by YoonieMac on 6/8/25.
//

import XCTest
@testable import ShinyModel
@testable import ShinyTestResource

final class ForecastTests: DecodableTests<Forecast> {

    override func setUpWithError() throws {
        jsonString = ShinyTestResource.JsonString.forecast
        try super.setUpWithError()
    }
}
