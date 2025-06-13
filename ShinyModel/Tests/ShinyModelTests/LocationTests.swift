//
//  LocationTests.swift
//  ShinyModel
//
//  Created by YoonieMac on 6/8/25.
//

import XCTest
@testable import ShinyModel
@testable import ShinyTestResource

final class LocationTests: DecodableTests<[Location]> {

    override func setUpWithError() throws {
        jsonString = ShinyTestResource.JsonString.reverseGeocoding
        try super.setUpWithError()
    }
}
