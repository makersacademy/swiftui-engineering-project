//
//  CreatePostPage.swift
//  MobileAcebook
//
//  Created by Makers Admin on 11/10/2023.
//

import SwiftUI

class CreatePost {
    let title: String
    let content: String
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
    
    func CreatePost() -> Void {
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/posts")!)
        
        request.httpMethod = "POST"
        
        let postData = ["title": title, "content": content]
        
        guard let jsonResultData = try? JSONSerialization.data(withJSONObject: postData) else {
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

