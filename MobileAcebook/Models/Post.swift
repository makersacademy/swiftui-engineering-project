//
//  Post.swift
//  MobileAcebook
//
//  Created by Benjamin Pearl on 17/04/2024.
//

import Foundation



//public struct Post {
//    let id: String
//    let message: String
//    let author: User
//    let timestamp: Date
//    var comments: [Comment]
//    var likes: [Like]
//    var imgUrl: String?
//}

struct Post: Identifiable, Equatable, Decodable {
    let id: String // Assuming 'id' is a string in your backend schema
    let message: String
    let createdAt: Date // Assuming 'createdAt' is a Date in your backend schema
    let createdBy: String // Assuming 'createdBy' is a string representing user ID
    var imgUrl: String? // Assuming 'imgUrl' is a String in your backend schema
    var likes: [String] // Assuming 'likes' is an array of user IDs as strings

    // Implement Equatable protocol
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }
}
