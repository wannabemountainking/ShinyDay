//
//  Double+Formatter.swift
//  ShinyDay
//
//  Created by yoonie on 2/24/25.
//

import Foundation

fileprivate let temperatureFormatter: MeasurementFormatter = {
    let formatter = MeasurementFormatter()
    formatter.locale = Locale(identifier: "ko_kr")
    formatter.numberFormatter.maximumFractionDigits = 1
    formatter.unitOptions = .temperatureWithoutUnit
    return formatter
}()

extension Double {
    var temperatureString: String {
        let temp = Measurement<UnitTemperature>(value: self, unit: .celsius)
        return temperatureFormatter.string(from: temp)
    }
}
