//
//  Post.swift
//  MobileAcebook
//
//  Created by Cloud Spotter on 12/10/2023.
//

import Foundation

struct Post: Codable { // Josué has this as public for the user - public here too?
    var id: String  // From MongoDB _id
    var message: String
    var image: String?
    var createdBy: String // ObjectID in backend post model but that's not a swift data type
    var createdAt: Date
}

struct CreatePost: Codable {
    var message: String
    var image: String?  // Optional until Cloudinary upload functionality and reference available
}
