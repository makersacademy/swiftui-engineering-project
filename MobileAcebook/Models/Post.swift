import SwiftUI

public struct Post: Decodable {
    let id: String
    let message: String
    let createdAt: Date
    let imgUrl: String?
    let createdBy: User
    
    private enum CodingKeys: String, CodingKey {
            case id = "_id"
            case message
            case createdAt
            case imgUrl
            case createdBy
        }
    public init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           id = try container.decode(String.self, forKey: .id)
           message = try container.decode(String.self, forKey: .message)
           imgUrl = try container.decodeIfPresent(String.self, forKey: .imgUrl)
           createdBy = try container.decode(User.self, forKey: .createdBy)

           // Decode createdAt string from JSON into a Date object
           let dateString = try container.decode(String.self, forKey: .createdAt)
           let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
           createdAt = dateFormatter.date(from: dateString) ?? Date()
       }
}
