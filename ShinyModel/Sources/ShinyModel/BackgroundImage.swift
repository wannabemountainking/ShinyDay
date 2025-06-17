//
//  BackgroundImage.swift
//  ShinyDay
//
//  Created by yoonie on 2/26/25.
//

import Foundation


public struct BackgroundImage: Codable, Equatable {
    public struct ImageUrl: Codable, Equatable {
        public let regular: URL
    }
    public let urls: ImageUrl
    
    public struct User: Codable, Equatable {
        public enum CodingKeys: String, CodingKey {
            case userName = "username"
        }
        public let userName: String
    }
    public let user: User
}
