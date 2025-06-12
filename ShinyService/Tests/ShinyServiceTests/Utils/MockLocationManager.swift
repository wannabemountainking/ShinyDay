//
//  File.swift
//  ShinyService
//
//  Created by YoonieMac on 6/11/25.
//

import Foundation
import CoreLocation
@testable import ShinyService

// 서브클래싱 방식으로 Test Double -> Spy
class MockLocationManager: LocationManager, @unchecked Sendable {
    
    // update가 순서대로 되는지 보여주는 코드
    var order = [String]()
    
    override var location: CLLocation? {
        didSet {
            order.append("location")
        }
    }
    
    override var lastLocation: CLLocation? {
        didSet {
            order.append("lastLocation")
        }
    }
    
    override func update(currentLocation: CLLocation) {
        order.append(#function)
        super.update(currentLocation: currentLocation)
    }
    
}

/*
 Mock : 행동기반 테스트에 사용하는 Test Double. 예를 들어 특정 Delegate 메서드가 호출되었을 때 구현한 코드가 의도한 순서대로 실행되는지 파악 등
 
 Test Double 구현 시 주로 사용하는 방법: 1. Protocol, 2. Subclassing

 1. 프로토콜: 구현이 복잡하지만 비교적 확실
 + : 클래스 + 구조체
 + : 테스트 격리
 - : 코드량 증가
 - : 비공개 멤버에 접근 불가
 
 2. 서브클래싱: 구현은 용이하나 상속이 갖는 각종 단점(강한 결합 등)의 영향을 받음
 + : 코드 재사용, 구현이 쉽고 빠름
 + : 클래스 Only
 - : 상속이 가능한 경우로 제한. 1) 구조체 등은 불가 2) final class 불가 3) 이미 다른 상속이 되어 있는 클레스 불가(다중상속 불가)
 - : 강한 결합. 1) 클래스가 바뀌면 서브클래스도 영향을 받음 2) 테스트 범위에 속하지 않은 멤버가 테스트 결과에 영향을 주는 경우도 발생 (메모리 누수?)
 ==> 코드의 양이 적은 서브클래싱으로 했다가 상속이나 결합 등 문제가 생기면 프로토콜로 접근
 */
