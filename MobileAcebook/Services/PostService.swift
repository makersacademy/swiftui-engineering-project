import Foundation

struct PostResponse: Codable {
    let posts: [Post]
    let user: User
    let token: String
}

class PostService: PostServiceProtocol, ObservableObject {
    func fetchPosts(completion: @escaping ([Post]?, Error?) -> Void) {
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjVkNzRkZTM2YTc3YjA2MmRiZDljOGE3IiwiaWF0IjoxNzA4NjA5MDc0LCJleHAiOjE3MDkwNDEwNzR9.Sb2_LEb7UcqGLpGQMPsJvlmq3tBDrAFlSbdDiuYovm0" // temporary token only used locally, will be saved in separed gitignored file later on
        guard let url = URL(string: "http://127.0.0.1:8080/posts") else {
            completion(nil, nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
//             Print the raw JSON response as a string for debugging
//            if let data = data, let jsonString = String(data: data, encoding: .utf8) {
//                print("Raw JSON response: \(jsonString)")
//            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                completion(nil, nil) // Consider creating a specific error to return here
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(PostResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(responseData.posts, nil)
                }
            } catch {
                print("Decoding error: \(error)")
                // If possible, print more detailed error info
                if let decodingError = error as? DecodingError {
                    switch decodingError {
                    case .dataCorrupted(let context), .keyNotFound(_, let context), .typeMismatch(_, let context), .valueNotFound(_, let context):
                        print(context.debugDescription)
                        print(context.codingPath.map { $0.stringValue }.joined(separator: " -> "))
                    @unknown default:
                        print("Unknown decoding error")
                    }
                }
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }.resume()
    }
}
