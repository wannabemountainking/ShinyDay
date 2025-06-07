//
//  Double+FormatterTests.swift
//  ShinyFormatter
//
//  Created by YoonieMac on 6/7/25.
//

import XCTest
@testable import ShinyFormatter

final class Double_FormatterTests: XCTestCase {
    
    func testTemperatureString_returnsCelsiusStringWithoutTemperatureUnit() {
        // arrange
        let expected = "12.4°"
        // act
        let formatted = 12.3643.temperatureString
        // assert
        print(expected, formatted)
        XCTAssertEqual(expected, formatted)
    }
    
    // 소수부분이 0이면 정수부분만 포메팅해서 리턴하는지
    func testTemperatureString_ifFractionDigitIsZero_returnsIntegerString() {
        // arrange
        let expected = "12°"
        // act
        let formatted = 12.0.temperatureString
        // assert
        print(expected, formatted)
        XCTAssertEqual(expected, formatted)
    }
    
    // numberFormatter가 소수이하를 1자리로 제한하는지
    func testValueString_includesOnlyOneFractionDigit() {
        // arrange
        let expected = "1.2"
        // act
        let formatted = 1.23456.valueString
        // assert
        XCTAssertEqual(expected, formatted)
    }
    
    // 소수부분이 0일때 정수부분만 포메팅하는지
    func testValueString_ifFractionDigitIsZero_returnsIntegerString
() {
        // arrange
        let expected = "1"
        // act
        let formatted = 1.0.valueString
        // assert
        XCTAssertEqual(expected, formatted)
    }
}
