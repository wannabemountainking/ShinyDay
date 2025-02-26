//
//  Int+Formatter.swift
//  ShinyDay
//
//  Created by yoonie on 2/26/25.
//

import Foundation


fileprivate let pressureFormatter: MeasurementFormatter = {
    let f = MeasurementFormatter()
    f.locale = Locale(identifier: "ko_kr")
    f.numberFormatter.maximumFractionDigits = 0
    return f
}()

fileprivate let numberFormatter: NumberFormatter = {
    let f = NumberFormatter()
    f.numberStyle = .decimal
    return f
}()

extension Int {
    var pressureString: String {
        let pressure = Measurement<UnitPressure>(value: Double(self), unit: .hectopascals)
        return pressureFormatter.string(from: pressure)
    }
    
    var pressureStringWithoutUnit: String {
        return numberFormatter.string(for: self) ?? "\(self)"
    }
    
    var visibilityString: String {
        return numberFormatter.string(for: (self / 1000)) ?? "\(self / 1000)"
    }
}
