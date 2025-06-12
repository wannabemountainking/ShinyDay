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
    
    // sut을 속성으로 만들기(systmeUnderTest)
    // spy를 속성으로 만들기
    // fake를 속성으로 만들기
    // stub을 속성으로 만들고 location 상수 속성 설정
    var sut: MockLocationManager!
    var locationManagerSpy: CLLocationManagerSpy!
    var userDefaultsFake: FakeUserDefaults!
    var stubGeocoder: StubCLGeocoder!
    let dummyLocagtion = CLLocation(latitude: 12, longitude: 34)
    
    override func setUpWithError() throws {
        locationManagerSpy = CLLocationManagerSpy()
        userDefaultsFake = FakeUserDefaults()
        stubGeocoder = StubCLGeocoder()
    }
    
    // 하나의 테스트가 끝나면 실행하는 코드
    override func tearDownWithError() throws {
        sut = nil
        locationManagerSpy = nil
        userDefaultsFake = nil
        stubGeocoder = nil
    }
    
    // 생성자에서 잘 초기화하는지
    // test double에서 dummy 사용해서 구현
    func testInit_initializeProperly() {
        // arrange
        let dummy = DummyCLLocationManager()
        sut = MockLocationManager(locationManager: dummy)
        
        // act
        
        // assert
        // 최초 값이 nil로 설정되어 있는지
        XCTAssertNil(sut.location)
        XCTAssertNil(sut.locationName)
        XCTAssertNil(sut.backgroundImage)
        // init에서 초기화하는 속성 설정 확인
        XCTAssertEqual(dummy.distanceFilter, 1000)
        XCTAssertEqual(dummy.desiredAccuracy, kCLLocationAccuracyKilometer)
        // instance의 주소 비교(값비교: 비교연산자, 주소 비교: 항등연산자 사용)
        XCTAssertIdentical(dummy.delegate, sut)
    }
    
    // test double 중에 spy를 사용해서 구현
    func testInit_callsWhenInUse() {
        // arrange
        //  test 메서드에서 spy 객체를 생성하면 spy객체를 생성하고 spy 객체의 속성 requestWhenInUseCalled는 false가 됨.
//        let spy = CLLocationManagerSpy()
        // act
        //  그리고 LocationManager의 생성자가 동작하여 spy.requestWhenInUseAuthorization()이 호출되어 requestWhenInUseCalled는 true가 됨.
        let _ = LocationManager(locationManager: locationManagerSpy)
        // assert
        XCTAssertTrue(locationManagerSpy.requestWhenInUseCalled)
    }
    /*
     spy처럼 메소드의 호출 여부나 호출 횟수를 검증하는 것을 행동관찰이라고 함
     */
    
    // LocationManager의 LastLocation이 nil일 때
    func testInit_ifLastLocationIsNil_doesNotCallUpdateCurrentLocation() {
        // arrange
        // 1. 빈 FakeUserDefaults 저장공간(queue 형태) 설정,
//        let fake = FakeUserDefaults()
        // act
        // 2. LocationManager를 상속받은 spy객체가 형성되면 LocationManager가 init되면서 lastLocation이 있는지 검토하는데 이때는 lastLocation의 중요 요소인 UserDefaults의 데이터가 비어있어(fake) lastLocation이 nil이어서 LocationManager에서 update가 작동하지 않아 spy.updateCurrentLocationCalled == false가 됨
        let spy = LocationManagerSpy(userDefaults: userDefaultsFake)
        // assert
        XCTAssertFalse(spy.updateCurrentLocationCalled)
    }
    
    // LocationManager의 LastLocation이 nil이 아닐 때
    func testInit_ifLastLocationIsNotNil_callsUpdateCurrentLocation() {
        // arrange
        // 1. 빈 FakeUserDefaults 저장공간(queue 형태) 설정 후 위치(경도, 위도) 데이터 추가
//        let fake = FakeUserDefaults()
        userDefaultsFake.set(38.22, forKey: "lastLocationLat")
        userDefaultsFake.set(126.11, forKey: "lastLocationLon")
        // act
        // 2.LocationManager를 상속받은 spy객체가 형성되면 LocationManager가 init되면서 lastLocation이 있는지 검토하는데 이때는 lastLocation의 중요 요소인 UserDefaults의 데이터가 채워져서(notNil) lastLocation이 값이 있어 LocationManager에서 update가 작동하여 spy.updateCurrentLocationCalled == true가 됨
        let spy = LocationManagerSpy(userDefaults: userDefaultsFake)
        // assert
        XCTAssertTrue(spy.updateCurrentLocationCalled)
    }
    
    // Geocoder와 Stub을 한번에 바꿔주는 메서드 설정
    func arrangeWithGeocoder(name: String? = nil,
                             locality: String? = nil,
                             subLocality: String? = nil,
                             descriptionStr: String = "",
                             returnsEmptyArray: Bool = false,
                             throwsError: Bool = false) {
        stubGeocoder = StubCLGeocoder(name: name, locality: locality, subLocality: subLocality, descriptionStr: descriptionStr, returnsEmptyArray: returnsEmptyArray, throwsError: throwsError)
        sut = MockLocationManager(geocoder: stubGeocoder)
    }
    
    //updateLocationName 메서드 테스트(locationName 잘 설정되는지 확인
    func testUpdateLocationName_setsLocationName() async {
        // arrange
//        let stub = StubCLGeocoder()
//        let sut = MockLocationManager(geocoder: stub)
        arrangeWithGeocoder()
//        let location = CLLocation(latitude: 12, longitude: 34)
        // act
        await sut.updateLocationName(location: dummyLocagtion)
        // assert
        XCTAssertNotNil(sut.locationName)
    }
    
    // updateLocationName 메서드에서 placemark의 속성 name이 있을때 locationName이 placemark.name과 같은지
    func testUpdateLocationName_ifNameIsNotNil_locationNameEqualsName() async {
        // arrange
        let expectedLocationName = "신도림역"
//        stub = StubCLGeocoder(name: expectedLocationName)
//        let sut = MockLocationManager(geocoder: stub)
        arrangeWithGeocoder(name: expectedLocationName)
//        let location = CLLocation(latitude: 12, longitude: 34)
        // act
        await sut.updateLocationName(location: dummyLocagtion)
        // assert
        XCTAssertEqual(expectedLocationName, sut.locationName)
    }
    
    // Placemark의 locality 검사
    
    func testUpdateLocationName_ifLocalityIsNotNil_locationNameEqualsLocality() async {
        // arrange
        let expectedLocationName = "강남구"
//        stub = StubCLGeocoder(locality: expectedLocationName)
//        let sut = MockLocationManager(geocoder: stub)
        arrangeWithGeocoder(locality: expectedLocationName)
//        let location = CLLocation(latitude: 12, longitude: 34)
        // act
        await sut.updateLocationName(location: dummyLocagtion)
        // assert
        XCTAssertEqual(expectedLocationName, sut.locationName)
    }
    
    // Placemark의 subLocality 검사
    func testUpdateLocationName_ifSubLocalityIsNotNil_locationNameEqualsLocalityPlusSubLocality() async {
        // arrange
        let expectedLocalityPlusSubLocationName = "강남구 역삼동"
        let localityList = expectedLocalityPlusSubLocationName.components(separatedBy: " ")
//        stub = StubCLGeocoder(locality: localityList.first ?? "", subLocality: localityList.last ?? "")
//        
//        let sut = MockLocationManager(geocoder: stub)
        
        arrangeWithGeocoder(locality: localityList.first ?? "", subLocality: localityList.last ?? "")
//        let location = CLLocation(latitude: 12, longitude: 34)
        // act
        await sut.updateLocationName(location: dummyLocagtion)
        // assert
        XCTAssertEqual(expectedLocalityPlusSubLocationName, sut.locationName)
    }
    
    // locality와 sublocality가 모두 nil일때
    // Placemark의 subLocality 검사
    func testUpdateLocationName_ifOnlyDescriptionIsNotNil_locationNameEqualsDescription() async {
        // arrange
        let expectedLocationName = "강남대로"
//        
//        stub = StubCLGeocoder(descriptionStr: expectedLocationName)
//        
//        let sut = MockLocationManager(geocoder: stub)
        
        arrangeWithGeocoder(descriptionStr: expectedLocationName)
//        let location = CLLocation(latitude: 12, longitude: 34)
        // act
        await sut.updateLocationName(location: dummyLocagtion)
        // assert
        XCTAssertEqual(expectedLocationName, sut.locationName)
    }
    
    // StubGeocoder에서 placemark의 속성들의 비열이 모두 비어있을 때
    func testUpdateLocationName_ifPlacemarkIsEmpty_locationNameEqualsUnknown() async {
        // arrange
        let expectedLocationName = "알 수 없음"
        
//        stub = StubCLGeocoder(returnsEmptyArray: true)
//        
//        let sut = MockLocationManager(geocoder: stub)
        
        arrangeWithGeocoder(returnsEmptyArray: true)
//        let location = CLLocation(latitude: 12, longitude: 34)
        // act
        await sut.updateLocationName(location: dummyLocagtion)
        // assert
        XCTAssertEqual(expectedLocationName, sut.locationName)
    }
    
    // updateLocationName 메서드의 catch블럭 테스트
    func testUpdateLocationName_ifThrowsError_locationNameEqualsUnknown() async {
        // arrange
        let expectedLocationName = "알 수 없음"
        
//        stub = StubCLGeocoder(throwsError: true)
//        
//        let sut = MockLocationManager(geocoder: stub)
        
        arrangeWithGeocoder(throwsError: true)
//        let location = CLLocation(latitude: 12, longitude: 34)
        // act
        await sut.updateLocationName(location: dummyLocagtion)
        // assert
        XCTAssertEqual(expectedLocationName, sut.locationName)
    }
    
    func arrangeWithAuthorizationStatus(_ status: CLAuthorizationStatus) {
        locationManagerSpy.stubbedAuthorizationStatus = status
        sut = MockLocationManager(locationManager: locationManagerSpy)
    }
    
    // CLLocationManagerDelegate에서 AuthorizationStatus가 .notDetermined일 떼
    func testDelegate_ifAuthorizationStatusIsNotDetermined_callsRequestWhenInUse() {
        // arrange
//        spy.stubbedAuthorizationStatus = .notDetermined
//        sut = MockLocationManager(locationManager: spy)
        arrangeWithAuthorizationStatus(.notDetermined)
        // act: Delegate 메서드는 원래 자동 호출되지만 테스트에서는 우리가 직접해야 함
        sut.locationManagerDidChangeAuthorization(locationManagerSpy)
        
        // assert
        XCTAssertTrue(locationManagerSpy.requestWhenInUseCalled)
        XCTAssertEqual(2, locationManagerSpy.requestWhenInUseCallCount)
        XCTAssertFalse(locationManagerSpy.startUpdatingLocationCalled)
    }
    
    // 로케이션메니저가 허가된 상태에서 startUpdatingLocation 메서드가 작동하는지
    func testDelegate_ifAuthorizationStatusIsAuthorized_callsStartUpdatingLocation() {
        var num = 0
        for status in [CLAuthorizationStatus.authorizedAlways, .authorizedWhenInUse] {
            num += 1
            // arrange
//            spy.stubbedAuthorizationStatus = status
//            sut = MockLocationManager(locationManager: spy)
            arrangeWithAuthorizationStatus(status)
            // act
            sut.locationManagerDidChangeAuthorization(locationManagerSpy)
            
            // assert
            XCTAssertEqual(num, locationManagerSpy.requestWhenInUseCallCount)
            XCTAssertTrue(locationManagerSpy.startUpdatingLocationCalled)
        }
    }
    
    // authorizationStatus가 notAuthorized, Error 일때
    func testDelegate_ifAuthorizationStatusIsNotAuthorizedOrError_callsNothing() {
        var num = 0
        for status in [CLAuthorizationStatus.denied, .restricted] {
            num += 1
            // arrange
//            spy.stubbedAuthorizationStatus = status
//            sut = MockLocationManager(locationManager: spy)
            arrangeWithAuthorizationStatus(status)
            // act
            sut.locationManagerDidChangeAuthorization(locationManagerSpy)
            // assert
            XCTAssertEqual(num, locationManagerSpy.requestWhenInUseCallCount)
            XCTAssertFalse(locationManagerSpy.startUpdatingLocationCalled)
        }
    }
    
    // delegate 중 didFailWithError 테스트
    func testDidFailWithError_ifErrorCodeIsUnknown_callsNothing() {
        // arrange
//        let spy = CLLocationManagerSpy()
        sut = MockLocationManager(locationManager: locationManagerSpy)
        let error = NSError(domain: kCLErrorDomain, code: CLError.Code.locationUnknown.rawValue)
        // act
        sut.locationManager(locationManagerSpy, didFailWithError: error)
        print(locationManagerSpy.stopUpdatingLocationCalled)
        // assert
        XCTAssertFalse(locationManagerSpy.stopUpdatingLocationCalled)
    }
    
    func testDidFailWithError_ifErrorCodeIsNotUnknown_callsStopUpdatingLocation() {
        // arrange
//        let spy = CLLocationManagerSpy()
        sut = MockLocationManager(locationManager: locationManagerSpy)
        let error = NSError(domain: kCLErrorDomain, code: CLError.Code.locationUnknown.rawValue)
        // act
        sut.locationManager(locationManagerSpy, didFailWithError: error)
        print(locationManagerSpy.stopUpdatingLocationCalled)
        // assert
        XCTAssertFalse(locationManagerSpy.stopUpdatingLocationCalled)
    }
    
    func testDidUpdateLocations_runsExpectedOrder() {
        // arrange
        sut = MockLocationManager(userDefaults: userDefaultsFake)
        let expectedOrder = ["location", "lastLocation", "update(currentLocation:)"]
        // act
        sut.locationManager(locationManagerSpy, didUpdateLocations: [dummyLocagtion])
        // assert
        XCTAssertEqual(expectedOrder, sut.order)
    }
    
    // update(currentLocation:) 테스트: 1. locationName이 잘 업뎃되는지 2. 이 변화가 일어나면 바로 post가 되는지
    @MainActor
    func testDidUpdateLocationName_updatesLocationNameAndPostsLocationNameDidUpdate() {
        // arrange
        arrangeWithGeocoder(name: "강남역")
        // noti를 테스트할 때 Expectation 객체 사용
        expectation(forNotification: .locationNameDidUpdate, object: nil)
        // act
        sut.locationManager(locationManagerSpy, didUpdateLocations: [dummyLocagtion])
        // assert
        waitForExpectations(timeout: 1) // 1초안에 호출하면 성공
        XCTAssertNotNil(sut.locationName)
    }
}



