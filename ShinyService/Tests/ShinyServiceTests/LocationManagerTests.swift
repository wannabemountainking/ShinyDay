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
    
    //updateLocationName 메서드 테스트(locationName 잘 설정되는지 확인
    func testUpdateLocationName_setsLocationName() async {
        // arrange
        let stub = StubCLGeocoder()
        let sut = LocationManager(geocoder: stub)
        let location = CLLocation(latitude: 12, longitude: 34)
        // act
        await sut.updateLocationName(location: location)
        // assert
        XCTAssertNotNil(sut.locationName)
    }
    
    // updateLocationName 메서드에서 placemark의 속성 name이 있을때 locationName이 placemark.name과 같은지
    func testUpdateLocationName_ifNameIsNotNil_locationNameEqualsName() async {
        // arrange
        let expectedLocationName = "신도림역"
        let stub = StubCLGeocoder(name: expectedLocationName)
        let sut = LocationManager(geocoder: stub)
        let location = CLLocation(latitude: 12, longitude: 34)
        // act
        await sut.updateLocationName(location: location)
        // assert
        XCTAssertEqual(expectedLocationName, sut.locationName)
    }
    
    // Placemark의 locality 검사
    
    func testUpdateLocationName_ifLocalityIsNotNil_locationNameEqualsLocality() async {
        // arrange
        let expectedLocationName = "강남구"
        let stub = StubCLGeocoder(locality: expectedLocationName)
        let sut = LocationManager(geocoder: stub)
        let location = CLLocation(latitude: 12, longitude: 34)
        // act
        await sut.updateLocationName(location: location)
        // assert
        XCTAssertEqual(expectedLocationName, sut.locationName)
    }
    
    // Placemark의 subLocality 검사
    func testUpdateLocationName_ifSubLocalityIsNotNil_locationNameEqualsLocalityPlusSubLocality() async {
        // arrange
        let expectedLocalityPlusSubLocationName = "강남구 역삼동"
        let localityList = expectedLocalityPlusSubLocationName.components(separatedBy: " ")
        let stub = StubCLGeocoder(locality: localityList.first ?? "", subLocality: localityList.last ?? "")
        
        let sut = LocationManager(geocoder: stub)
        let location = CLLocation(latitude: 12, longitude: 34)
        // act
        await sut.updateLocationName(location: location)
        // assert
        XCTAssertEqual(expectedLocalityPlusSubLocationName, sut.locationName)
    }
    
    // locality와 sublocality가 모두 nil일때
    // Placemark의 subLocality 검사
    func testUpdateLocationName_ifOnlyDescriptionIsNotNil_locationNameEqualsDescription() async {
        // arrange
        let expectedLocationName = "강남대로"
        
        let stub = StubCLGeocoder(descriptionStr: expectedLocationName)
        
        let sut = LocationManager(geocoder: stub)
        let location = CLLocation(latitude: 12, longitude: 34)
        // act
        await sut.updateLocationName(location: location)
        // assert
        XCTAssertEqual(expectedLocationName, sut.locationName)
    }
    
    // StubGeocoder에서 placemark의 속성들의 비열이 모두 비어있을 때
    func testUpdateLocationName_ifPlacemarkIsEmpty_locationNameEqualsUnknown() async {
        // arrange
        let expectedLocationName = "알 수 없음"
        
        let stub = StubCLGeocoder(returnsEmptyArray: true)
        
        let sut = LocationManager(geocoder: stub)
        let location = CLLocation(latitude: 12, longitude: 34)
        // act
        await sut.updateLocationName(location: location)
        // assert
        XCTAssertEqual(expectedLocationName, sut.locationName)
    }
    
    // updateLocationName 메서드의 catch블럭 테스트
    func testUpdateLocationName_ifThrowsError_locationNameEqualsUnknown() async {
        // arrange
        let expectedLocationName = "알 수 없음"
        
        let stub = StubCLGeocoder(throwsError: true)
        
        let sut = LocationManager(geocoder: stub)
        let location = CLLocation(latitude: 12, longitude: 34)
        // act
        await sut.updateLocationName(location: location)
        // assert
        XCTAssertEqual(expectedLocationName, sut.locationName)
    }
    
    // CLLocationManagerDelegate에서 AuthorizationStatus가 .notDetermined일 떼
    func testDelegate_ifAuthorizationStatusIsNotDetermined_callsReturnWhenInUse() {
        // arrange
        let spy = CLLocationManagerSpy(stubbedAuthorizationStatus: .notDetermined)
        let sut = MockLocationManager(locationManager: spy)
        // act: Delegate 메서드는 원래 자동 호출되지만 테스트에서는 우리가 직접해야 함
        sut.locationManagerDidChangeAuthorization(spy)
        
        // assert
        XCTAssertTrue(spy.requestWhenInUseCalled)
        XCTAssertEqual(2, spy.requestWhenInUseCallCount)
        XCTAssertFalse(spy.startUpdatingLocationCalled)
    }
    
    // 로케이션메니저가 허가된 상태에서 startUpdatingLocation 메서드가 작동하는지
    func testDelegate_ifAuthorizationStatusIsAuthorized_callsStartUpdatingLocation() {
        for status in [CLAuthorizationStatus.authorizedAlways, .authorizedWhenInUse] {
            // arrange
            let spy = CLLocationManagerSpy(stubbedAuthorizationStatus: status)
            let sut = MockLocationManager(locationManager: spy)
            // act
            sut.locationManagerDidChangeAuthorization(spy)
            
            // assert
            XCTAssertEqual(1, spy.requestWhenInUseCallCount)
            XCTAssertTrue(spy.startUpdatingLocationCalled)
        }
    }
    
    // authorizationStatus가 notAuthorized, Error 일때
    func testDelegate_ifAuthorizationStatusIsNotAuthorizedOrError_callsNothing() {
        for status in [CLAuthorizationStatus.denied, .restricted] {
            // arrange
            let spy = CLLocationManagerSpy(stubbedAuthorizationStatus: .denied)
            let sut = MockLocationManager(locationManager: spy)
            // act
            sut.locationManagerDidChangeAuthorization(spy)
            // assert
            XCTAssertEqual(1, spy.requestWhenInUseCallCount)
            XCTAssertFalse(spy.startUpdatingLocationCalled)
        }
    }
    
    // delegate 중 didFailWithError 테스트
    func testDidFailWithError_ifErrorCodeIsUnknown_callsNothing() {
        // arrange
        let spy = CLLocationManagerSpy()
        let sut = MockLocationManager(locationManager: spy)
        let error = NSError(domain: kCLErrorDomain, code: CLError.Code.locationUnknown.rawValue)
        // act
        sut.locationManager(spy, didFailWithError: error)
        print(spy.stopUpdatingLocationCalled)
        // assert
        XCTAssertFalse(spy.stopUpdatingLocationCalled)
    }
    
    func testDidFailWithError_ifErrorCodeIsNotUnknown_callsStopUpdatingLocation() {
        // arrange
        let spy = CLLocationManagerSpy()
        let sut = MockLocationManager(locationManager: spy)
        let error = NSError(domain: kCLErrorDomain, code: CLError.Code.locationUnknown.rawValue)
        // act
        sut.locationManager(spy, didFailWithError: error)
        print(spy.stopUpdatingLocationCalled)
        // assert
        XCTAssertFalse(spy.stopUpdatingLocationCalled)
    }
}



