//
//  PostService.swift
//  MobileAcebook
//
//  Created by Cloud Spotter on 12/10/2023.


import Foundation

// Custom error type to return token authentication error message
struct AppError: LocalizedError {
    let errorDescription: String?
    static let authenticationError = AppError(errorDescription: "Authentication failed. Token not recognised.") // 'static' defines a shared instance, reusable across the rest of the code
}


// Get all posts function




// New post function (using CreatePost data model)
func createPost(newPost: CreatePost, completion: @escaping (Result<Void, Error>) -> Void) {
    // Try converting the string into a URL
    guard let url = URL(string: "http://127.0.0.1:8080/posts") else {
        completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
        return
    }
        
        // Establish a new POST request
        var request = URLRequest(url: url)  // Create a URL request object
        request.httpMethod = "POST"
        
        // Convert new post object into JSON data using JSONEncoder
        let encoder = JSONEncoder()

        if let jsonData = try? encoder.encode(newPost) {
            request.httpBody = jsonData // Set the JSON data as the request's body

            // Check for valid token in UserDefaults
            if let token = UserDefaults.standard.string(forKey: "user-token") {
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            } else {
                completion(.failure(AppError.authenticationError))
            }
                request.setValue("application/json", forHTTPHeaderField: "Content-Type") 
            
            // Create a data task that will handle the request and the server's response (asynchonous)
            let createPostTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {              // Check for errors in the response
                    completion(.failure(error))
                    return
                }
                
                // Check if the response code is anything other than 201 (Created)
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 201 {
                    let statusCode = httpResponse.statusCode
                    completion(.failure(NSError(domain: "", code: statusCode, userInfo: nil)))
                    return
                }
                
                // Closure (executed when network request completes successfully)
                completion(.success(()))
            }
            createPostTask.resume() // Start the 'create post' data task
        } else {
            // Handle error where the post data couldn't be encoded into JSON
            completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Failed to encode post data to JSON"])))
        }
    }

