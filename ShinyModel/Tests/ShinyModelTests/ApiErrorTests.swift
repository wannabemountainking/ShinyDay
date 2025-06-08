//
//  ApiErrorTests.swift
//  ShinyModel
//
//  Created by YoonieMac on 6/8/25.
//

import XCTest
@testable import ShinyModel

// 타입이 에러 프로토콜을 채용하는지만 검사
final class ApiErrorTests: XCTestCase {
    
    func testApiError_conformsErrorProtocol() {
        // assert: enum의 요소 하나만으로도 Error 프로토콜을 채택여부 알 수 있음
        XCTAssertTrue(ApiError.emptyData is Error)
    }

}
