//
//  FeedService.swift
//  MobileAcebook
//
//  Created by Alice Birkett on 11/10/2023.
//

import Foundation

class FeedService {
    
    typealias FeedCallback = (Posts?, Error?) -> Void
    
    func getAllPosts (token: String, completion: @escaping FeedCallback) -> Void {
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/posts")!)
        
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print(request.debug())
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let data = data {
                if let posts = try?
                    JSONDecoder().decode(Posts.self, from: data) {
                    completion(posts, nil)
                } else {
                    completion(nil, NSError(domain: "Invalid data", code: 500, userInfo: nil))
                }
            }
        }
        task.resume()
    }
}

fileprivate extension URLRequest {
    func debug() {
        print("\(self.httpMethod!) \(self.url!)")
        print("Headers:")
        print(self.allHTTPHeaderFields!)
        print("Body:")
        print(String(data: self.httpBody ?? Data(), encoding: .utf8)!)
    }
}


