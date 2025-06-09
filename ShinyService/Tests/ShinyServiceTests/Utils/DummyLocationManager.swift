//
//  File.swift
//  ShinyService
//
//  Created by YoonieMac on 6/9/25.
//

import Foundation
import CoreLocation
@testable import ShinyService

// 테스트에서 dummy는 실제 기능이 없이 interface만 충족시키는 비어있는 객체 = 모든 속성은 default값
class DummyLocationManager: LocationManaging {
    var distanceFilter: CLLocationDistance = kCLDistanceFilterNone
    var desiredAccuracy: CLLocationAccuracy = kCLLocationAccuracyBest
    var delegate: (any CLLocationManagerDelegate)?
    
    func requestWhenInUseAuthorization() {}
}

/*
 dummy: 비어있는 가상의 객체 == 메서드 구현이 비어있고 속성은 값을 저장하는 이외의 역할 없음
 dummy는 인터페이스를 충족만 시키는 것으로 테스트에 필요한 최소한의 멤버나 여기에 필요한 타입을 제공함

 */
