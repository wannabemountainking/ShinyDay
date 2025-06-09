//
//  LocationManagerTests.swift
//  ShinyService
//
//  Created by YoonieMac on 6/9/25.
//

import XCTest
@testable import ShinyService
import CoreLocation

final class LocationManagerTests: XCTestCase {
    
    // 생성자에서 잘 초기화하는지
    func testInit_initializeProperly() {
        // arrange
        let dummy = DummyLocationManager()
        let systemUnderTest = LocationManager(locationManager: dummy)
        
        // act
        
        // assert
        // 최초 값이 nil로 설정되어 있는지
        XCTAssertNil(systemUnderTest.location)
        XCTAssertNil(systemUnderTest.locationName)
        XCTAssertNil(systemUnderTest.backgroundImage)
        // init에서 초기화하는 속성 설정 확인
        XCTAssertEqual(dummy.distanceFilter, 1000)
        XCTAssertEqual(dummy.desiredAccuracy, kCLLocationAccuracyKilometer)
        // instance의 주소 비교(값비교: 비교연산자, 주소 비교: 항등연산자 사용)
        XCTAssertIdentical(dummy.delegate, systemUnderTest)
    }
    
}
