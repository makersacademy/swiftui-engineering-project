//
//  Post.swift
//  MobileAcebook
//
//  Created by Jess Todd on 16/04/2024.
//

import Foundation

public struct CreatedBy: Codable {
    let _id: String
    let username: String
    let profilePicture: String
}

public struct Post: Codable {
    let _id: String?
    let message: String?
    let createdAt: String
    let imgUrl: String?
    let likes: [String]
    let createdBy: CreatedBy
}



