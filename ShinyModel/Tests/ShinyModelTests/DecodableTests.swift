//
//  DecodableTests.swift
//  ShinyModel
//
//  Created by YoonieMac on 6/8/25.
//

import XCTest

class DecodableTests<T: Codable>: XCTestCase {
    
    var jsonString: String!
    var json: Data!
    var decoder: JSONDecoder!
    var decodable: T!

    override func setUpWithError() throws {
        json = jsonString.data(using: .utf8)!
        decoder = JSONDecoder()
    }

    override func tearDownWithError() throws {
        jsonString = nil
        json = nil
        decoder = nil
        decodable = nil
    }
    
    func arrangeDecoding() {
        decodable = try! decoder.decode(T.self, from: json)
    }
    
    // JSON타입에서 에러가 발생하는지만 확인 -> arrange / act 생략
    func testJsonDecoding_succeeds() {
        // assert
        XCTAssertNoThrow(try decoder.decode(T.self, from: json))
    }

}
