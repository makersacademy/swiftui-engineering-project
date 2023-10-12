//
//  CreatePostPage.swift
//  MobileAcebook
//
//  Created by Makers Admin on 11/10/2023.
//

import SwiftUI
import Cloudinary

class CreatePost {
    let image: Data
    let message: String
    
    init(image: Data, message: String) {
        self.image = image
        self.message = message
    }
    
    func newPost(token: String) -> Void {
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/posts")!)
        
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        guard let cloudName = try? ProcessInfo.processInfo.environment["CLOUD_NAME"] else {
            return
        }
        
        guard let apiKey = try? ProcessInfo.processInfo.environment["API_KEY"] else {
            return
        }
        
        let config = CLDConfiguration(cloudName: cloudName, apiKey: apiKey)
        print("Config print \(config)")
        let cloudinary = CLDCloudinary(configuration: config)
        
        print("image print \(image)")
        
        if image != Data() {
            let cloudinaryData = cloudinary.createUploader().upload(data: image, uploadPreset: "kfwkzmqp")
            cloudinaryData.response({ (result, error) in
                if let error = error {
                    print (error)
                } else if let result = result {
                    print("Result print \(result)")
                    guard let cloudinaryString = try? result.publicId else {
                        return
                    }
                    
                    let postData = CreateNewPost(message: self.message, publicID: cloudinaryString)
                    
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
            })
            
//            let cloudinaryData = cloudinary.createUploader().upload(data: image, uploadPreset: "kfwkzmqp").response({
//                (response, error) in
//                print("Response print \(response)")
//                guard let cloudinaryResponseData = try? response else {
//                    print("Problem 1")
//                    return
//                }
//                guard let publicIdString = cloudinaryResponseData.publicId else {
//                    print("Problem 2")
//                    return
//                }
//                cloudinaryString = publicIdString
//            })
        } else {
            let postData = CreateNewPost(message: message, publicID: "")
            
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
}

