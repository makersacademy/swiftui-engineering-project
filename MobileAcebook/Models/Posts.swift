//
//  Posts.swift
//  MobileAcebook
//
//  Created by Alice Birkett on 11/10/2023.
//

import Foundation

public struct Posts: Codable {
    let posts: [[String:String]]
    let user: [String:String]
    let token: String
}
