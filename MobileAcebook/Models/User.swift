//
//  User.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

public struct User: Decodable {
    var email: String
    var username: String
    var password: String
    
    init(email: String, username: String, password: String) {
           self.email = email
           self.username = username
           self.password = password
       }
    
    enum CodingKeys: String, CodingKey {
        case email
        case username
        case password
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        email = try container.decode(String.self, forKey: .email)
        username = try container.decode(String.self, forKey: .username)
        password = try container.decode(String.self, forKey: .password)
    }
    

}
