//
//  User.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

public struct User {
    let email: String
    let password: String
}

public struct Token: Codable {
    let message: String
    let token: String
}
