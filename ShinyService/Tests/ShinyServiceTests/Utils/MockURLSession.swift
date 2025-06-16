//
//  File.swift
//  ShinyService
//
//  Created by YoonieMac on 6/16/25.
//

import Foundation
@testable import ShinyService

class MockURLSession: URLSessionType, @unchecked Sendable {
    
    var statusCode: Int?
    var urlRequest: URLRequest?
    
    // url응답결과
    var urlResponse: URLResponse {
        if let statusCode {
            return HTTPURLResponse(url: urlRequest!.url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
        } else {
            return HTTPURLResponse(url: urlRequest!.url!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        }
    }
    
    // cache 정책
    var cachePolicy: URLRequest.CachePolicy? {
        return urlRequest?.cachePolicy
    }
    
    // 여러 request를 보냈는지, 어떤 url을 보냈는지 RequestTiming 구조체 생성
    struct RequestTiming {
        let url: URL
        let start: TimeInterval
        let end: TimeInterval
    }
    
    var dataForRequestCallCount = 0
    var dataForRequestCallTimings = [RequestTiming]()
    var dataForRequestUrls = [URL]()
    
    init(statusCode: Int? = 200) {
        self.statusCode = statusCode
    }
    
    // URLSession에 사용할 json 데이터 리턴(그 과정에서 requestTiming에 관한 정보 수집)
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        let start = Date.now.timeIntervalSinceReferenceDate
        dataForRequestCallCount += 1
        dataForRequestUrls.append(request.url!)
        
        self.urlRequest = request
        
        let data = Endpoint.sampleJson(for: request.url!)!
        let end = Date.now.timeIntervalSinceReferenceDate
        let timing = RequestTiming(url: request.url!, start: start, end: end)
        dataForRequestCallTimings.append(timing)
        
        return (data, urlResponse)
    }
    
    // queryItem은 있는지: 1. url 이있고 2. url componens에 queryItems 가 있는지
    func exists(queryItemNamed name: String, with value: String) -> Bool {
        guard let url = urlRequest?.url else {return false}
        guard let items = URLComponents(string: url.absoluteString)?.queryItems else {return false}
        
        return items.contains { $0.name == name && $0.value == value }
    }
    
    // headers가 있는지
    func exists(httpHeaderNamed name: String, with value: String) -> Bool {
        guard let headers = urlRequest?.allHTTPHeaderFields else {return false}
        return headers[name] == value
    }
    
    // 여러 개의 요청을 동시에 보낼 때 각 요청시작시간(RequestTiming.start)과 종료시간(RequestTiming.end)이 겹치는 지
    // 두 구간의 겹침에 대한 검증 논리: A의 시작 < B의 종료 && B의 시작 < A의 종료
    func isConcurrentForAllRequests() -> Bool {
        guard dataForRequestCallCount > 1 else {return false}
        for i in 0 ..< dataForRequestCallTimings.count {
            for j in i ..< dataForRequestCallTimings.count {
                if dataForRequestCallTimings[i].start < dataForRequestCallTimings[j].end && dataForRequestCallTimings[j].start < dataForRequestCallTimings[i].end {
                    return true
                }
            }
        }
        return false
    }
    
    // 특정 URL로 요청을 보냈는지 확인
    func checkReqeustUrlMatches(endpoints: [Endpoint]) -> Bool {
        for url in dataForRequestUrls {
            for endpoint in endpoints {
                if let host = url.host, host == endpoint.host, url.path.hasSuffix(endpoint.path) {
                    return true
                }
            }
        }
        return false
    }
    
}

extension Endpoint: CaseIterable {
    public static var allCases: [Endpoint] {
        return [
            .weather(0, 0, .standard),
            .forecast(0, 0, .standard),
            .air_pollution(0, 0, .standard),
            .reverseGeocoding(0, 0),
            .randomImage("")
        ]
    }
    
    static func sampleJson(for url: URL) -> Data! {
        guard let host = url.host else {return nil}
        
        for endpoint in Endpoint.allCases {
            //url.path는 "/"로 시작함. 반면에 endpoint.path는 "/"없이 시작함.그래서 endpoint.path를 많이 사용함
            if endpoint.host == host && url.path.hasSuffix(endpoint.path) {
                return endpoint.sampleJson
            }
        }
        return nil
    }
}
