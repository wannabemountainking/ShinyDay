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
    // test double에서 dummy 사용해서 구현
    func testInit_initializeProperly() {
        // arrange
        let dummy = DummyCLLocationManager()
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
    
    // test double 중에 spy를 사용해서 구현
    func testInit_callsWhenInUse() {
        // arrange
        //  test 메서드에서 spy 객체를 생성하면 spy객체를 생성하고 spy 객체의 속성 requestWhenInUseCalled는 false가 됨.
        let spy = CLLocationManagerSpy()
        // act
        //  그리고 LocationManager의 생성자가 동작하여 spy.requestWhenInUseAuthorization()이 호출되어 requestWhenInUseCalled는 true가 됨.
        let _ = LocationManager(locationManager: spy)
        // assert
        XCTAssertTrue(spy.requestWhenInUseCalled)
    }
    /*
     spy처럼 메소드의 호출 여부나 호출 횟수를 검증하는 것을 행동관찰이라고 함
     */
    
    // LocationManager의 LastLocation이 nil일 때
    func testInit_ifLastLocationIsNil_doesNotCallUpdateCurrentLocation() {
        // arrange
        // 1. 빈 FakeUserDefaults 저장공간(queue 형태) 설정,
        let fake = FakeUserDefaults()
        // act
        // 2. LocationManager를 상속받은 spy객체가 형성되면 LocationManager가 init되면서 lastLocation이 있는지 검토하는데 이때는 lastLocation의 중요 요소인 UserDefaults의 데이터가 비어있어(fake) lastLocation이 nil이어서 LocationManager에서 update가 작동하지 않아 spy.updateCurrentLocationCalled == false가 됨
        let spy = LocationManagerSpy(userDefaults: fake)
        // assert
        XCTAssertFalse(spy.updateCurrentLocationCalled)
    }
    
    // LocationManager의 LastLocation이 nil이 아닐 때
    func testInit_ifLastLocationIsNotNil_callsUpdateCurrentLocation() {
        // arrange
        // 1. 빈 FakeUserDefaults 저장공간(queue 형태) 설정 후 위치(경도, 위도) 데이터 추가
        let fake = FakeUserDefaults()
        fake.set(38.22, forKey: "lastLocationLat")
        fake.set(126.11, forKey: "lastLocationLon")
        // act
        // 2.LocationManager를 상속받은 spy객체가 형성되면 LocationManager가 init되면서 lastLocation이 있는지 검토하는데 이때는 lastLocation의 중요 요소인 UserDefaults의 데이터가 채워져서(notNil) lastLocation이 값이 있어 LocationManager에서 update가 작동하여 spy.updateCurrentLocationCalled == true가 됨
        let spy = LocationManagerSpy(userDefaults: fake)
        // assert
        XCTAssertTrue(spy.updateCurrentLocationCalled)
    }
}



