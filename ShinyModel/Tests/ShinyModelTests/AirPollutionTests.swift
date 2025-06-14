//
//  AirPollutionTests.swift
//  ShinyModel
//
//  Created by YoonieMac on 6/8/25.
//

import XCTest
@testable import ShinyModel
@testable import ShinyTestResource

final class AirPollutionTests: DecodableTests<AirPollution> {
    // 유닛테스트에서는 서버에 직접접근하지 않고 대신에 JSON 문자열을 복사헤서 사용함
    var o3String: String!
    var pm10String: String!
    var pm25String: String!
    var airPollution: AirPollution! {
        return decodable
    }
    var numFormatter: NumberFormatter!
    
    override func setUpWithError() throws {
        jsonString = ShinyTestResource.JsonString.airPollution
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        numFormatter = nil
    }
    
    // 정규식 메서드 구현
    func replaceValue(pattern: String, with value: String) {
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let results = regex.matches(in: jsonString, options: [], range: NSRange(jsonString.startIndex..., in: jsonString))
        if let match = results.first {
            if let range = Range(match.range(at: 1), in: jsonString) {
                jsonString = jsonString.replacingCharacters(in: range, with: value)
            }
        }
    }
    
    // 디코딩을 미리하는 메서드 작성
    // Unit Test에서는 !사용 권장(에러를 빨리 알아야 함)
    func arrangeDecoding(aqi: Int? = nil, o3: Double? = nil, pm10: Double? = nil, pm2_5: Double? = nil) {
        
        if let aqi {
            replaceValue(pattern: "\"aqi\":\\s*(\\d+)", with: "\(aqi)")
        }
        
        if let o3 {
            replaceValue(pattern: "\"o3\":\\s*(\\d+\\.?\\d*)", with: "\(o3)")
        }
        
        if let pm10 {
            replaceValue(pattern: "\"pm10\":\\s*(\\d+\\.?\\d*)", with: "\(pm10)")
        }
        
        if let pm2_5 {
            replaceValue(pattern: "\"pm2_5\":\\s*(\\d+\\.?\\d*)", with: "\(pm2_5)")
        }
        
        json = jsonString.data(using: .utf8)!
        
        super.arrangeDecoding()
    }
    
    // valueString을 반영하는 formatter 생성
    func arrangeValueFormatter() {
        numFormatter = NumberFormatter()
        numFormatter.maximumFractionDigits = 1
    }
    
    
    // infoList 속성 테스트(배열의 요소수, title)
    func testInfoList_returnsArrayInExpectingOrder() {
        // arrange
        arrangeDecoding()
        let expectedCount = 4
        let expectedTitles = ["대기질", "오존", "미세먼지", "초미세먼지"]
        // act
        let actualCount = airPollution.infoList.count
        let actualTitles = airPollution.infoList.map { $0.title }
        // assert
        XCTAssertEqual(expectedCount, actualCount)
        XCTAssertEqual(expectedTitles, actualTitles)
    }
    
    // infoList에서 대기질 테스트
    // 이미지 비교시는 데이터 타입(pngData())을 비교해야 함. 그래야 개별 픽셀을 비교하게 되고 정확히 같은 이미지인지 비교 가능
    func testInfoList_firstDataIsAQI() {
        // arrange
        arrangeDecoding(aqi: 3)
        let expectedImage = UIImage(systemName: "aqi.medium")!.pngData()!
        let expectedTitle = "대기질"
        let expectedValue = "보통"
        let expectedDescription = "AQI - 3"
        // act
        let actualImage = airPollution.infoList[0].image!.pngData()!
        let actualTitle = airPollution.infoList[0].title
        let actualValue = airPollution.infoList[0].value
        let actualDescription = airPollution.infoList[0].description
        // assert
        XCTAssertEqual(expectedImage, actualImage)
        XCTAssertEqual(expectedTitle, actualTitle)
        XCTAssertEqual(expectedValue, actualValue)
        XCTAssertEqual(expectedDescription, actualDescription)
    }
    
    // 오존
    func testInfoList_secondDataIsO3() {
        // arrange
        arrangeDecoding(o3: 81.66)
        let expectedImage = UIImage(systemName: "aqi.medium")!.pngData()!
        let expectedTitle = "오존"
        let expectedValue = "81.7"
        let expectedDescription = "O₃ - µg/m³"
        // act
        let actualImage = airPollution.infoList[1].image!.pngData()!
        let actualTitle = airPollution.infoList[1].title
        let actualValue = airPollution.infoList[1].value
        let actualDescription = airPollution.infoList[1].description
        // assert
        XCTAssertEqual(expectedImage, actualImage)
        XCTAssertEqual(expectedTitle, actualTitle)
        XCTAssertEqual(expectedValue, actualValue)
        XCTAssertEqual(expectedDescription, actualDescription)
    }
    
    // 미세먼지
    func testInfoList_thirdDataIsPM10() {
        // arrange
        arrangeDecoding(pm10: 30.95)
        let expectedImage = UIImage(systemName: "aqi.medium")!.pngData()!
        let expectedTitle = "미세먼지"
        let expectedValue = "31"
        let expectedDescription = "PM10 - µg/m³"
        // act
        let actualImage = airPollution.infoList[2].image!.pngData()!
        let actualTitle = airPollution.infoList[2].title
        let actualValue = airPollution.infoList[2].value
        let actualDescription = airPollution.infoList[2].description
        // assert
        XCTAssertEqual(expectedImage, actualImage)
        XCTAssertEqual(expectedTitle, actualTitle)
        XCTAssertEqual(expectedValue, actualValue)
        XCTAssertEqual(expectedDescription, actualDescription)
    }
    
    // 초미세먼지
    func testInfoList_fourthDataIsPM25() {
        // arrange
        arrangeDecoding(pm2_5: 28.12)
        let expectedImage = UIImage(systemName: "aqi.medium")!.pngData()!
        let expectedTitle = "초미세먼지"
        let expectedValue = "28.1"
        let expectedDescription = "PM2.5 - µg/m³"
        // act
        let actualImage = airPollution.infoList[3].image!.pngData()!
        let actualTitle = airPollution.infoList[3].title
        let actualValue = airPollution.infoList[3].value
        let actualDescription = airPollution.infoList[3].description
        // assert
        XCTAssertEqual(expectedImage, actualImage)
        XCTAssertEqual(expectedTitle, actualTitle)
        XCTAssertEqual(expectedValue, actualValue)
        XCTAssertEqual(expectedDescription, actualDescription)
    }
    func testAqiString_returnsDescriptiveString() {
        for aqi in 1...6 {
            // arrange
            arrangeDecoding(aqi: aqi)
            let expected = ["좋음", "보통", "보통", "나쁨", "매우 나쁨", "--"][aqi - 1]
            // act
            let actual = airPollution.aqiString
            // assert
            XCTAssertEqual(expected, actual)
        }
    }
    
    func testO3String_returnsValueString() {
        // arrange
        let randomValue = Double.random(in: 0.01...0.99)
        arrangeDecoding(o3: randomValue)
        arrangeValueFormatter()
        let expected = numFormatter.string(for: randomValue)!
        // act
        let actual = airPollution.o3String
        // assert
        XCTAssertEqual(expected, actual)
    }
    
    func testPm10String_returnsValueString() {
        // arrange
        let randomValue = Double.random(in: 0.01...0.99)
        arrangeDecoding(pm10: randomValue)
        arrangeValueFormatter()
        let expected = numFormatter.string(for: randomValue)
        // act
        let actual = airPollution.pm10String
        // assert
        XCTAssertEqual(expected, actual)
    }
    
    func testPm25String_returnsValueString() {
        // arrange
        let randomValue = Double.random(in: 0.01...0.99)
        arrangeDecoding(pm2_5: randomValue)
        arrangeValueFormatter()
        let expected = numFormatter.string(for: randomValue)!
        // act
        let actual = airPollution.pm25String
        // assert
        XCTAssertEqual(expected, actual)
    }
}
