//
//  Double+Formatter.swift
//  ShinyDay
//
//  Created by yoonie on 2/24/25.
//

import Foundation

//fileprivate let temperatureFormatter: MeasurementFormatter = {
//    let formatter = MeasurementFormatter()
//    formatter.locale = Locale(identifier: "ko_kr")
//    formatter.numberFormatter.maximumFractionDigits = 1
//    formatter.unitOptions = .temperatureWithoutUnit
//    return formatter
//}()

//fileprivate let numberFormatter: NumberFormatter = {
//    let f = NumberFormatter()
//    f.maximumFractionDigits = 1
//    return f
//}()

public extension Double {
    var temperatureString: String {
        let temp = Measurement<UnitTemperature>(value: self, unit: .celsius)
        
        let formatter = MeasurementFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.numberFormatter.maximumFractionDigits = 1
        formatter.unitOptions = .temperatureWithoutUnit
        
        return formatter.string(from: temp)
    }
    var valueString: String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        return formatter.string(for: self) ?? "\(self)"
    }
}
