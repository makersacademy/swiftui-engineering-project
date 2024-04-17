//
//  PostService.swift
//  MobileAcebook
//
//  Created by Bogdan Stăiculescu on 17/04/2024.
//

import Foundation

class postService {
    
    // response returned on succesful /POST request
    struct Response: Codable {
        // let message : String
        let token: String
    }
    
    
    func createPost(post: Post, token: String, completion: @escaping ((String) -> Void)) -> Bool {
        // defining URL to which we make the POST on the Backend
        guard let url = URL(string: "http://localhost:3000/posts") else
        {return false}
        
        // var that contains the URL request and content
        var urlRequest = URLRequest(url: url)
        // method of the createPost
        urlRequest.httpMethod = "POST"
        // value of the URL request that's being sent to backend [application/json]
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // also passing along Bearer and Token to show authorization
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        // defining the body of the HTTP request
        let body = post
        
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        
        // defining what we do with the response of our request
        let task = URLSession.shared.dataTask(with: urlRequest) {data, response, error in
            // ensures there is data that returns after making the request ELSE print error
            guard let data = data else {return}
            // if there is data
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                //print(response.token)
                DispatchQueue.main.async {
                    completion(response.token)
                }
                print("Post Created")
            }
            catch {
                print(error)
            }
        }
        task.resume()
        return true
    }
}
