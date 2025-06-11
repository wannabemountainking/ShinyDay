//
//  File.swift
//  ShinyService
//
//  Created by YoonieMac on 6/10/25.
//

import Foundation
import CoreLocation
@testable import ShinyService

/*
 Stub: 객체가 제공하는 기능 중에서 테스트에 필요한 기능만 최소로 구현한 객체
 Fake와의 차이점: 실제 값을 리턴하는 것(Fake)이 아니라 고정된 값을 리턴함
 여기서는 파라미터로 전달되는 로케이션은 무시하고 미리 준비한 값을 리턴하거나 에러를 던짐
 
 fake: 외부에서 봤을 때 동작은 달라지지 않지만 내부 구현은 테스트에 맍게 단순화해서 구현(유사 저장 등...)
 stub: 메서드에서 고정된 값이나 미리 준비된 값만 리턴함
 */

class StubCLGeocoder: Geocodable {
    let name: String?
    let locality: String?
    let subLocality: String?
    let descriptionStr: String
    private let returnsEmptyArray: Bool
    private let throwsError: Bool
    
    init(name: String? = nil,
         locality: String? = nil,
         subLocality: String? = nil,
         descriptionStr: String = "",
         returnsEmptyArray: Bool = false,
         throwsError: Bool = false) {
        self.name = name
        self.locality = locality
        self.subLocality = subLocality
        self.descriptionStr = descriptionStr
        self.returnsEmptyArray = returnsEmptyArray
        self.throwsError = throwsError
    }
    
    //CLPlacemark는 생성자가 공개되지 않아 우리가 만들수 없음 따라서 protocol을 사용해서 기능을 사용해야 함
    func reverseGeocodeLocation(_ location: CLLocation, preferredLocale locale: Locale?) async throws -> [PlacemarkType] {
        if throwsError {
            throw NSError(domain: "test", code: 0)
        }
        if returnsEmptyArray {
            return []
        }
        return [
            StubPlacemark(name: name, locality: locality, subLocality: subLocality, description: descriptionStr)
        ]
    }
}

struct StubPlacemark: PlacemarkType {
    let name: String?
    let locality: String?
    let subLocality: String?
    let description: String
}
