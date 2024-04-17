//
//  Post.swift
//  MobileAcebook
//
//  Created by Alannah Lawlor on 16/04/2024.
//

import Foundation

public struct Post: Codable {
    let _id: String
    let message: String
    let createdAt: Date
    let imgUrl: String?
    let createdBy: [String:String]
}

public struct PostAPIResponse: Codable {
    let token: String
    let posts: [Post]
}

public enum PostAPIError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)
    case invalidData
}

extension Post: Equatable {
    public static func == (lhs: Post, rhs: Post) -> Bool {
        // Compare the properties of the posts to determine equality
        return lhs._id == rhs._id
            && lhs.message == rhs.message
            && lhs.createdAt == rhs.createdAt
            && lhs.imgUrl == rhs.imgUrl
            && lhs.createdBy == rhs.createdBy
    }
}
