//
//  PostService.swift
//  MobileAcebook
//
//  Created by Benjamin Pearl on 17/04/2024.
//

import Foundation
import Combine

class PostService: ObservableObject {
    @Published var posts: [Post] = []
    @Published var newPostText = ""
    
    func fetchPosts(completion: @escaping ([Post]?, Error?) -> Void) {
        guard let url = URL(string: "http://localhost:3000/posts") else {
            completion(nil, NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let token = "Your JWT Token" // You'll replace this with your actual JWT token handling logic
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                do {
                    let postsResponse = try JSONDecoder().decode([Post].self, from: data)
                    completion(postsResponse, nil)
                } catch {
                    print("Decoding error:", error)
                    completion(nil, error)
                }
            } else {
                completion(nil, NSError(domain: "", code: (response as? HTTPURLResponse)?.statusCode ?? 500, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch posts"]))
            }
        }.resume()
    }
}
