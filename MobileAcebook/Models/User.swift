//
//  User.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

public struct User: Hashable, Codable {
    let username: String
    let email: String
    let password: String
}
