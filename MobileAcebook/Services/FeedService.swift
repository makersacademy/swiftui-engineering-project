//
//  FeedService.swift
//  MobileAcebook
//
//  Created by Alice Birkett on 11/10/2023.
//

import Foundation

class FeedService {
    
    func getAllPosts (token: String) -> Void {
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/posts")!)
        
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            print(response)
        }
        task.resume()
    }
}
