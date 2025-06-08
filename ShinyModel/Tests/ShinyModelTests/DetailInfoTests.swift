//
//  DetailInfoTests.swift
//  ShinyModel
//
//  Created by YoonieMac on 6/8/25.
//

import XCTest
@testable import ShinyModel

// 생성자가 잘 작동하는지만 확인
final class DetailInfoTests: XCTestCase {
    
    func testInit_setsProperValue() {
        // arrange
        let expectedImage = UIImage(systemName: "star")!
        let expectedTitle = Date.now.description
        let expectedValue = UUID().uuidString
        let expectedDescription = Int.random(in: 1...5000).description
        // act
        let result = DetailInfo(image: expectedImage, title: expectedTitle, value: expectedValue, description: expectedDescription)
        // assert
        XCTAssertEqual(expectedImage.pngData()!, result.image!.pngData()!)
        XCTAssertEqual(expectedTitle, result.title)
        XCTAssertEqual(expectedValue, result.value)
        XCTAssertEqual(expectedDescription, result.description)
    }
}
