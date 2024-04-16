//
//  User.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

import Foundation

public struct User: Codable {
    public let username: String
    public let password: String
    public let email: String
    public let imgUrl: String

    public init(username: String, password: String, email: String, imgUrl: String) {
        self.username = username
        self.password = password
        self.email = email
        self.imgUrl = imgUrl
    }
}
