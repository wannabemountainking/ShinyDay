//
//  File.swift
//  ShinyService
//
//  Created by YoonieMac on 6/10/25.
//

import Foundation
import CoreLocation
@testable import ShinyService

// 상속방식으로 구현된 spy
class LocationManagerSpy: LocationManager, @unchecked Sendable {
    var updateCurrentLocationCalled = false
    
    override func update(currentLocation: CLLocation) {
        updateCurrentLocationCalled = true
    }
}
