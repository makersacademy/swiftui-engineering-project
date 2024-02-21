//
//  Post.swift
//  MobileAcebook
//
//  Created by Amy McCann on 21/02/2024.
//

import Foundation

struct Post: Codable, Identifiable{
    let id: Int?
    let _id: String
    let message: String
    let image: String
    let createdAt: String
    let createdBy: String
//    let comments:
//    let likes:
}
