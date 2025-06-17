//
//  WeatherApiTests.swift
//  ShinyService
//
//  Created by YoonieMac on 6/16/25.
//

import XCTest
import CoreLocation
@testable import ShinyService
@testable import ShinyModel
@testable import ShinyTestResource

final class WeatherApiTests: XCTestCase {
    
    // test에 필요한 속성(userDefaults, urlSession, url, lat, lon, dummylocation, MockWeatherApi
    
    var sut: MockWeatherApi!
    var userDefaults: FakeUserDefaults!
    var urlSession: MockURLSession!
    var dummyLocation: CLLocation!
    var dummyUrl: URL!
    
    var lat: Double {
        return dummyLocation.coordinate.latitude
    }
    
    var lon: Double {
        return dummyLocation.coordinate.longitude
    }
    

    override func setUpWithError() throws {
        urlSession = MockURLSession()
        userDefaults = FakeUserDefaults()
        sut = MockWeatherApi(session: urlSession, userDefaults: userDefaults)
        dummyLocation = CLLocation(latitude: 37.498206, longitude: 127.02761)
        dummyUrl = URL(string: "https://www.kxcoding.com")
    }

    override func tearDownWithError() throws {
        urlSession = nil
        userDefaults = nil
        sut = nil
        dummyLocation = nil
        dummyUrl = nil
    }

    // 생성자 테스트
    func testInit_initiallizeProperly() {
        // arrange
        
        // act
        
        // assert
        XCTAssertIdentical(userDefaults, sut.userDefaults)
        XCTAssertIdentical(urlSession, sut.session)
        
        XCTAssertNil(sut.summary)
        XCTAssertNil(sut.copyright)
        XCTAssertTrue(sut.forecastList.isEmpty)
        XCTAssertTrue(sut.detailInfo.isEmpty)
    }
    
    // fetch(lat:lon:) 메서드에서 weather, forecast, airpollution을 동시에 fetch를 보냈는지
    func testFetchLocation_fetchConcurrently() async throws {
        // arrange
        let expectedFetchCount = 3
        let expectedEndPoints: [Endpoint] = [
            Endpoint.weather(lat, lon, userDefaults),
            Endpoint.forecast(lat, lon, userDefaults),
            Endpoint.air_pollution(lat, lon, userDefaults)
        ]
        // act
        try await sut.fetch(lat: lat, lon: lon)
        // assert
        
        XCTAssertEqual(expectedFetchCount, urlSession.dataForRequestCallCount)
        XCTAssertTrue(urlSession.isConcurrentForAllRequests())
        XCTAssertTrue(urlSession.checkReqeustUrlMatches(endpoints: expectedEndPoints))
    }
    
    // fetch(lat:lon:)메서드의 summery가 weather 내용을 잘 parsing헸는지
    // 가짜 data를 담아서 parsing한 값이 기대값, 실제 메서드 사용이 실제값
    func testFetchLocation_setsSummaryToCurrentWeather() async throws {
        // arrange
        let data = ShinyTestResource.JsonData.currentWeather
        let expectedSummary = try! JSONDecoder().decode(CurrentWeather.self, from: data)
        // act
        try await sut.fetch(lat: lat, lon: lon)
        // assert
        XCTAssertEqual(expectedSummary, sut.summary)
    }
    
    // detailList 테스트
    func testFetchLocation_setsDetailList() async throws {
        // arrange
        let decoder = JSONDecoder()
        
        var data = ShinyTestResource.JsonData.currentWeather
        let weather = try! decoder.decode(CurrentWeather.self, from: data)
        
        data = ShinyTestResource.JsonData.airPollution
        let airPollution = try! decoder.decode(AirPollution.self, from: data)
        
        let expectedImages: [UIImage?] = [
            UIImage(systemName: "thermometer.variable.and.figure"),
            UIImage(systemName: "humidity"),
            UIImage(systemName: "gauge.with.dots.needle.50percent"),
            UIImage(systemName: "eye"),
            UIImage(systemName: "aqi.medium"),
            UIImage(systemName: "aqi.medium"),
            UIImage(systemName: "aqi.medium"),
            UIImage(systemName: "aqi.medium")
        ]
        
        let expectedTitles: [String] = [
            "체감온도", "습도", "기압", "가시거리", "대기질", "오존", "미세먼지", "초미세먼지"
        ]
        
        let expectedValues: [String] = [
            weather.main.feelsLike.temperatureString,
           "\(weather.main.humidity)%",
            weather.main.pressure.pressureStringWithoutUnit,
            weather.visibility.visibilityString,
            airPollution.aqiString,
            airPollution.o3String,
            airPollution.pm10String,
            airPollution.pm25String
        ]
        
        let expectedDescriptions = [
            "",
            "",
            "hPa",
            "km",
            "AQI - \(airPollution.list.first?.main.aqi ?? 0)",
            "O₃ - µg/m³",
            "PM10 - µg/m³",
            "PM2.5 - µg/m³"
        ]
        // act
        try await sut.fetch(lat: lat, lon: lon)
        
        // assert
        XCTAssertEqual(expectedImages, sut.detailInfo.map {$0.image})
        XCTAssertEqual(expectedTitles, sut.detailInfo.map {$0.title})
        XCTAssertEqual(expectedValues, sut.detailInfo.map {$0.value})
        XCTAssertEqual(expectedDescriptions, sut.detailInfo.map {$0.description})
    }
    
    // forecastList 검증하기
    func testFetchLocagtion_setsForecastList() async throws {
        // arrange
        let decoder = JSONDecoder()
        var data = ShinyTestResource.JsonData.forecast
        let forecast = try! decoder.decode(Forecast.self, from: data)
        let expectedDate = forecast.list.map { Date(timeIntervalSince1970: TimeInterval($0.dt))}
        let expectedTemp = forecast.list.map {$0.main.temp}
        let expectedStatus = forecast.list.map {$0.weather.first?.description ?? "알 수 없음"}
        let expectedIcon = forecast.list.map {$0.weather.first?.icon ?? ""}
        // act
        try await sut.fetch(lat: lat, lon: lon)
        // assert
        XCTAssertEqual(expectedDate, sut.forecastList.map {$0.date})
        XCTAssertEqual(expectedTemp, sut.forecastList.map {$0.temperature})
        XCTAssertEqual(expectedIcon, sut.forecastList.map {$0.icon})
        XCTAssertEqual(expectedStatus, sut.forecastList.map {$0.weatherStatus})
    }
}
