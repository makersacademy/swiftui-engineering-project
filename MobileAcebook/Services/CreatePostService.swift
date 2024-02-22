//
//  CreatePostService.swift
//  MobileAcebook
//
//  Created by Si on 21/02/2024.
//

import Foundation

struct CreatePostRequest: Codable {
    let message: String
    let publicID: String?
}

class CreatePostService {
    
    static func createPost(message: String, image: String? = nil, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:8080/posts") else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = retrieveTokenFromKeychain()?.token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            print("Failed to retrieve token from keychain.")
            completion(false)
            return
        }
        
        // Use the provided image or a default one if nil
        let defaultImage = "public_id" // Default ImageId
        let postData = CreatePostRequest(message: message, publicID: image ?? defaultImage)
        
        do {
            let jsonData = try JSONEncoder().encode(postData)
            print(String(data: jsonData, encoding: .utf8)!) // Debugging line to see the JSON
            request.httpBody = jsonData
        } catch {
            print("Error encoding post data: \(error)")
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                completion(false)
                return
            }
            completion(true)
        }.resume()
    }
}
