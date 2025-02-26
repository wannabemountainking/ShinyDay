//
//  BackgroundImage.swift
//  ShinyDay
//
//  Created by yoonie on 2/26/25.
//

import Foundation


struct BackgroundImage: Codable {
    struct ImageUrl: Codable {
        let regular: URL
    }
    let urls: ImageUrl
    
    struct User: Codable {
        enum CodingKeys: String, CodingKey {
            case userName = "username"
        }
        let userName: String
    }
}
