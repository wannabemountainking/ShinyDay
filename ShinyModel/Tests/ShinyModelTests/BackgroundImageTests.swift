//
//  BackgroundImageTests.swift
//  ShinyModel
//
//  Created by YoonieMac on 6/8/25.
//

import XCTest
@testable import ShinyModel
@testable import ShinyTestResource

// Decoding이 잘 되는지만 테스트
final class BackgroundImageTests: DecodableTests<BackgroundImage> {
    
    override func setUpWithError() throws {
        jsonString = ShinyTestResource.JsonString.randomImage
        try super.setUpWithError()
    }
}
