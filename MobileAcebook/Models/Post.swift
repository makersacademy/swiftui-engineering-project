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
    var likes: [String]?
    let createdAt: Date
    let imgUrl: String?
    let createdBy: [String:String]
}

public struct PostAPIResponse: Codable {
    let token: String
    let posts: [Post]
}

public struct LikeAPIResponse: Codable {
    let post: LikePost
    let token: String
    let message: String
}

public struct LikePost: Codable {
    var _id: String
    var message: String
    var likes: [String]?
    var createdAt: String
    var imgUrl: String?
    var createdBy: String
    let __v: Int
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
