//
//  GetPosts.swift
//  MobileAcebook
//
//  Created by Bogdan Stăiculescu and George Paul on 18/04/2024.
//

import Foundation

class FeedService: ObservableObject {
    @Published var postsData = [Post]()
    // Response returned on successful GET request
    struct Response: Codable {
        let posts: [Post]
        let token: String
    }
    
    func getPost(token: String, completion: @escaping ((Response) -> Void)) {
        guard let url = URL(string: "http://localhost:3000/posts") else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                return
            }
            do {
                let jsonString = String(data: data, encoding: .utf8)
                    print("Received JSON: \(jsonString ?? "")")
                let response = try JSONDecoder().decode(Response.self, from: data)
                DispatchQueue.main.async {
                    completion(response)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
