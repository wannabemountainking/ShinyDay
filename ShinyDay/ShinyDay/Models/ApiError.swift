//
//  ApiError.swift
//  ShinyDay
//
//  Created by yoonie on 2/22/25.
//

import Foundation


enum ApiError: Error {
    case invalidUrl(String)
    case unknown
    case invalidResponse
    case failed(Int)
    case emptyData
}
