//
//  Posts.swift
//  MobileAcebook
//
//  Created by Alice Birkett on 11/10/2023.
//

import Foundation

public struct Posts: Codable {
    let posts: [Post]
    let token: String
}
public struct Post: Codable {
    let likes: [String]
    let comments: Int
    let _id: String
    let message: String
    let user: String
    let createdAt: String
    let updatedAt: String
}

