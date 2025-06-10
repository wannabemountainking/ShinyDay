//
//  File.swift
//  ShinyService
//
//  Created by YoonieMac on 6/10/25.
//

import Foundation
import CoreLocation
@testable import ShinyService

// LocationManager의 속성 lastLocation 테스트
// 속성이 계산속성이고 UserDefaults에 저장된 값을 사용하므로(입력, 출력시 값이 달라질 수 있음) fake파일로 UserDefaults를 만들고 처리

class FakeUserDefaults: UserDefaults {
    // 메모리 저장소도 딕셔너리(문자열: Any) 속성으로 구현
    var store = [String: Any]()
    
    let queue = DispatchQueue(label: "com.doyoonkim.FakeUserDefaults", attributes: .concurrent)
    
    // test에서 사용하는 메서드를 overriding
    // key값으로 value찾는 메서드(UserDefaults를 완전대체해서 super필요 없음
    override func object(forKey defaultName: String) -> Any? {
        queue.sync {
            return store[defaultName]
        }
    }
    
    override func set(_ value: Any?, forKey defaultName: String) {
        queue.sync(flags: .barrier) {
            store[defaultName] = value
        }
    }
    // flag = .barrier는 여기에서 전달하는 작업이 해당 queue에 있는 다른 모든 작업이 완료된 다음에 실행하도록 보장해주고, 이 클로저가 실행되는 동안 다른 작업이 실행되지 않도록 보장함
    // test에서는 원래 사용하는 모든메서드 overriding해야 함
    
}

