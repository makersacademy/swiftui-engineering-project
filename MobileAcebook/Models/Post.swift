//
//  Post.swift
//  MobileAcebook
//
//  Created by Jess Todd on 16/04/2024.
//

import Foundation

public struct Post: Encodable {
    let message: String
    let date: String
    let user: String
    let profilePicture: String
}
