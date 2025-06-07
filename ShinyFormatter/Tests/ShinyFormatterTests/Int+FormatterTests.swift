//
//  Int+FormatterTests.swift
//  ShinyFormatter
//
//  Created by YoonieMac on 6/7/25.
//

import XCTest
@testable import ShinyFormatter

final class Int_FormatterTests: XCTestCase {

    // pressureString은 기한문자열로 포맷팅해서 리턴하는 지 테스트
    func testPressureString_returnsPressureStringWithoutFractionDigits() {
        // arrange
        let expected = "1,200hPa"
        // act
        let formatted = 1200.pressureString
        // assert
        XCTAssertEqual(expected, formatted)
    }
    
    // pressureStringWithoutUnit은 Unit없이 리턴하는지
    func testPressureStringWithoutUnit_returnsPressureStringWithoutUnit() {
        // arrange
        let expected = "1,200"
        // act
        let formatted = 1200.pressureStringWithoutUnit
        // assert
        XCTAssertEqual(expected, formatted)
    }
    
    func testVisibilityString_returnsKmStringWithDecimalFormat() {
        // arrange
        let expected = "10,000"
        // act
        let formatted = 10_000_000.visibilityString
        // assert\
        XCTAssertEqual(expected, formatted)
    }

}
