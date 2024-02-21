//
//  User.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//
import Foundation

struct User: Codable {
    let username: String
    let avatar: String
    let id: String
    let email: String
    let password: String
    let __v: Int

    enum CodingKeys: String, CodingKey {
        case username, avatar, email, password, __v
        case id = "_id" // Correct mapping for "_id" from JSON to "id" in Swift
    }

    // Custom initializer if needed
    init(username: String, email: String, password: String, avatar: String = "/default_avatar.png", id: String = UUID().uuidString, __v: Int = 0) {
        self.username = username
        self.avatar = avatar
        self.id = id
        self.email = email
        self.password = password
        self.__v = __v
    }
}