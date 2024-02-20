//
//  Post.swift
//  MobileAcebook
//
//  Created by Demetrius Vissarion on 20/02/2024.
//

import Foundation

public struct Post: Hashable, Codable, Identifiable {
    public let id: String
    let message: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id" // Map the "_id" JSON key to the "id" property
        case message, image
    }
    
    // If you're manually initializing Post objects elsewhere, keep the initializer,
    // but note that for decoding from JSON, this initializer isn't used.
    init(id: String = UUID().uuidString, message: String, image: String) {
        self.id = id
        self.message = message
        self.image = image
    }
}
