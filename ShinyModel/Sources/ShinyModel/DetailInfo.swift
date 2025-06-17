//
//  DetailInfo.swift
//  ShinyDay
//
//  Created by yoonie on 2/25/25.
//

import UIKit

public struct DetailInfo: Equatable {
    public let image: UIImage?
    public let title: String
    public let value: String
    public var description: String
    
    public init(image: UIImage?, title: String, value: String, description: String = "") {
        self.image = image
        self.title = title
        self.value = value
        self.description = description
    }
}
