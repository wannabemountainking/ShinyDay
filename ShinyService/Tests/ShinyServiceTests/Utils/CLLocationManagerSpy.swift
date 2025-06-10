//
//  LocationManagerSpy 2.swift
//  ShinyService
//
//  Created by YoonieMac on 6/10/25.
//


import Foundation
import CoreLocation
@testable import ShinyService

/*
 spy: 실제 객체와 비슷하게 동작하면서 특정 작업에 대한 추가적인 정보를 기록하는 객체로 주로 1. 메소드가 호출되는지 2. 몇 번 호출되는지 와 같은 것을 확인할 때 사용함
 여기에서의 spy는 dummy와 같이 프로토콜 구현 필요(1. 새로운 class 만들수도 있고 2. 상속해도 됨)
 */

class CLLocationManagerSpy: DummyCLLocationManager {
    var requestWhenInUseCalled = false
    
    override func requestWhenInUseAuthorization() {
        requestWhenInUseCalled = true
    }
}

