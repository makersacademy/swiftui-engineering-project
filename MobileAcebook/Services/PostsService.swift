import SwiftUI
import Foundation

class PostService {
    private var posts: [Post] = []
    struct PostResponse: Decodable {
        let posts: [Post]
        let token: String
    }
    
    static let shared = PostService()
    func fetchPosts(completion: @escaping ([Post]) -> Void) {
        guard let url = URL(string: "http://localhost:3000/posts") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjYxZDA5ZDNjMDZjMDViODAwYzkyODVkIiwiaWF0IjoxNzEzNDQ4NTM2LCJleHAiOjE3MTM0NDkxMzZ9.AGDxopqT89NjsFdveD10c8Dh7JhEMXewiOGcfIYIJFw"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        print(token)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching posts: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(PostResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(decodedResponse.posts)
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}
