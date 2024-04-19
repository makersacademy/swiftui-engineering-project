//
//  NewUser.swift
//  MobileAcebook
//
//  Created by Firat Gulmez on 16/04/2024.
//

import Foundation

public struct User: Codable {
    let _id: String?
    let email: String
    let password: String
    let username: String
    let imgurl: String?
}

struct SignupResult: Codable {
    let message: String
}
public struct GetUserResponse: Codable{
    let userData: [User]
    let token: String
}
