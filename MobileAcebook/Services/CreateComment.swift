//
//  CreateComment.swift
//  MobileAcebook
//
//  Created by Bogdan Stăiculescu on 18/04/2024.
//

import Foundation

class commentService {
    
    // response that is returned on succesful /POST createComment request
    struct createCommentsResponse: Codable {
         let message: String
        let token: String
    }
    
    // response that is returned on succesful /GET commentsOnPost request
    //        struct getCommentsResponse: Codable {
    //            // let message : String
    //            let comments: String
    //            let token: String
    //        }
    
    func createComment(comment: Comment, postID: String, token: String, completion: @escaping ((String) -> Void)) -> Bool {
        // defining the individual postID-URL to which we make the /POST request
        // of the new comment we want to create on the Backend
        guard let url = URL(string: "http://localhost:3000/comments/\(postID)") else { return false }
        
        // var that contains the URL request and content
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        // defining the body of the HTTP request
        let body = comment
        
        urlRequest.httpBody = try? JSONEncoder().encode(comment)
        
        
        // defining what we do with the response of our request
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            // ensures there is data that returns after making the request ELSE print error
            guard let data = data else { return }
            // if there is data
            do {
                let response = try JSONDecoder().decode(createCommentsResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response.token)
                }
                print("Comment Created")
            }
            catch {
                print(error)
            }
        }
        task.resume()
        return true
    }
    }
