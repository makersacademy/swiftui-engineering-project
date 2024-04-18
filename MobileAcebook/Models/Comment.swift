//
//  Comment.swift
//  MobileAcebook
//
//  Created by Amy Brown on 17/04/2024.
//

import Foundation
public struct Comment: Codable {
    let _id: String
    let message: String
    let createdAt: Date
    let createdBy: [String:String]
}

public struct CommentAPIResponse: Codable {
    let message: String
    let token: String
    let comments: [Comment]
}
