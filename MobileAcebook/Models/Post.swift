//
//  Post.swift
//  MobileAcebook
//

import Foundation

public struct Post: Hashable, Codable, Identifiable {
    public let id: String
    let message: String?
    let image: String?
    let createdBy: String
    let createdAt: Date
    let likes: [String]
    let comments: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case message, image, createdBy, createdAt, likes, comments
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        message = try container.decodeIfPresent(String.self, forKey: .message)
        image = try container.decodeIfPresent(String.self, forKey: .image)
        createdBy = try container.decode(String.self, forKey: .createdBy)
        
        let createdAtString = try container.decode(String.self, forKey: .createdAt)
        guard let date = DateFormatter.postDateFormatter.date(from: createdAtString) else {
            throw DecodingError.dataCorruptedError(forKey: .createdAt, in: container, debugDescription: "Date string does not match format expected by formatter.")
        }
        createdAt = date
        
        likes = try container.decode([String].self, forKey: .likes)
        comments = try container.decode(Int.self, forKey: .comments)
    }
}

extension DateFormatter {
    static let postDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

