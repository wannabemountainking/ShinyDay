//
//  Date+formatterTests.swift
//  ShinyFormatter
//
//  Created by YoonieMac on 6/7/25.
//

import XCTest
@testable import ShinyFormatter

final class Date_formatterTests: XCTestCase {

    // 특정 날짜를 초기화하는 메서드 작성(테스트를 위함)
    func arrangeDate(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date {
        let cal = Calendar.current
        let comp = DateComponents(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
        return cal.date(from: comp)!
    }
    
    // dateString이 "M월 d일"로 포멧되는지 확인
    func testDateString_returnsMonthAndDayFormattedString() {
            
        // arrange
        let date = arrangeDate(year: 2025, month: 12, day: 25)
        let expected = "12월 25일"
        // act
        let formatted = date.dateString
        // assert
        XCTAssertEqual(expected, formatted)
    }
    
    // dateString이 01처럼 한자리일 때 1처럼 0이 잘 떨어지는지
    func testDateString_withOneDigitComponent_returnsWithoutZeroPadding() {
        // arrange
        let date = arrangeDate(year: 2025, month: 1, day: 1)
        let expected = "1월 1일"
        // act
        let formatted = date.dateString
        // assert
        XCTAssertEqual(expected, formatted)
    }
    
    // timeString이 올바른 포맷으로 리턴하는지
    func testTimeString_returnsHourFormattedString() {
        // arrange
        let date = arrangeDate(year: 2025, month: 5, day: 25, hour: 15, minute: 9, second: 33)
        let expected = "15:00"
        // act
        let formatted = date.timeString
        // assert
        XCTAssertEqual(expected, formatted)
    }
    
    func testTimeString_HourLessThen10_addZeroPadding() {
        // arrange
        let date = arrangeDate(year: 2024, month: 12, day: 25, hour: 3, minute: 44, second: 9)
        let expected = "03:00"
        // act
        let formatted = date.timeString
        // assert
        XCTAssertEqual(expected, formatted)
    }
    
    func testTimeString_use24HourFormat() {
        // arrange
        let date = arrangeDate(year: 2024, month: 12, day: 25, hour: 13, minute: 44, second: 9)
        let expected = "13:00"
        // act
        let formatted = date.timeString
        // assert
        XCTAssertEqual(expected, formatted)
    }
    
    func testTimeString_minutesAlways00() {
        // arrange
        let date = arrangeDate(year: 2024, month: 12, day: 25, hour: 13, minute: 44, second: 9)
        // act
        let formatted = date.timeString
        // assert
        XCTAssertTrue(formatted.hasSuffix("00"))
    }
}
