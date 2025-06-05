//
//  Date+Formatter.swift
//  ShinyDay
//
//  Created by yoonie on 2/24/25.
//

import Foundation

fileprivate let dateFormatter: DateFormatter = {
    let f = DateFormatter()
    return f
}()

public extension Date {
    var dateString: String {
        dateFormatter.dateFormat = "M월 d일"
        return dateFormatter.string(from: self)
    }
    var timeString: String {
        dateFormatter.dateFormat = "HH:00"
        return dateFormatter.string(from: self)
    }
}
