import Foundation

struct PostResponse: Codable, Identifiable {
    let _id: String
    let likes: [String]
    let comments: Int
    let createdAt: String
    let createdBy: String?
    let message: String?
    let image: String?
    let __v: Int

    // Needed to satisfy Indentifiable protocol
    var id: String { _id }
}
