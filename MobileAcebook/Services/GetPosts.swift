//
//  GetPosts.swift
//  MobileAcebook
//
//  Created by Bogdan Stăiculescu and George Paul on 18/04/2024.
//

import Foundation

class PostService {
    
    // Response returned on successful GET request
    struct Response: Codable {
        let posts: [Post]
        let token: String
    }
    
    func getPost(token: String, completion: @escaping (([Post], String) -> Void)) {
        guard let url = URL(string: "http://localhost:3000/posts") else {
            completion([], "")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                completion([], "")
                return
            }
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                DispatchQueue.main.async {
                    completion(response.posts, response.token)
                }
            } catch {
                print(error)
                completion([], "")
            }
        }
        task.resume()
    }
}
