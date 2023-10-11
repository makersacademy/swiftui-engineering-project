//
//  User.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//
import Foundation

public struct User: Codable {
    let email: String
    let username: String
    let password: String
    let avatar: String?
}
