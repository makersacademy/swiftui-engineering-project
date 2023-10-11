//
//  CreatePostPage.swift
//  MobileAcebook
//
//  Created by Makers Admin on 11/10/2023.
//

import SwiftUI

class CreatePost {
    let image: String
    let message: String
    
    init(image: String, message: String) {
        self.image = image
        self.message = message
    }
    
    func newPost(token: String) -> Void {
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/posts")!)
        
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let postData = CreateNewPost(message: message, publicID: image)
        
        guard let jsonResultData = try? JSONEncoder().encode(postData) else {
            print("data not found")
            return
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonResultData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            print(response)
        }
        task.resume()
    }
}

