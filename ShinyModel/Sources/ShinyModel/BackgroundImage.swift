//
//  BackgroundImage.swift
//  ShinyDay
//
//  Created by yoonie on 2/26/25.
//

import Foundation


public struct BackgroundImage: Codable {
    public struct ImageUrl: Codable {
        public let regular: URL
    }
    public let urls: ImageUrl
    
    public struct User: Codable {
        public enum CodingKeys: String, CodingKey {
            case userName = "username"
        }
        public let userName: String
    }
    public let user: User
}
