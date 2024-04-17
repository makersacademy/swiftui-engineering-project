//
//  NewUser.swift
//  MobileAcebook
//
//  Created by Firat Gulmez on 16/04/2024.
//

import Foundation

public struct NewUser {
    let email: String
    let password: String
    let username: String
    let imgurl: String?
}

struct SingUpResult: Codable {
    let message: String
}
