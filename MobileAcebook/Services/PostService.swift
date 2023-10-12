//
//  PostService.swift
//  MobileAcebook
//
//  Created by Cloud Spotter on 12/10/2023.


import Foundation

// Get all posts function




// Create new post function (using CreatePost data model)
func createPost(newPost: CreatePost, completion: @escaping (Result<Void, Error>) -> Void) {
    // Try converting the string into a URL
    if let url = URL(string: "http://127.0.0.1:8080/posts") {
        print("Valid URL: \(url)") // Print the validated URL
        
        // Create a URL request object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Set the HTTP method to POST
        
        // Create post object to represent the post data to be sent to the server
        let postData = newPost
        
        // Create encoder object for encoding post data to JSON with encoder protocol
        let encoder = JSONEncoder()
        // Try converting the post object into JSON data
        if let jsonData = try? encoder.encode(newPost) {
            request.httpBody = jsonData // Set the JSON data as the request's body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type") // Set the request's content type header.
            print("converted swift to json request: ", request)  // TEMPORARY (for debugging)
            
            // Create a data task that will handle the request and the server's response
            let createPostTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                // Check for errors in the response
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                // Check if the response code is anything other than 201 (Created)
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 201 {
                    let statusCode = httpResponse.statusCode
                    completion(.failure(NSError(domain: "", code: statusCode, userInfo: nil)))
                    return
                }
                
                // If all is well, complete the request successfully
                completion(.success(()))
            }
            createPostTask.resume() // Start the data task
        } else {
            // Handle error where the post data couldn't be serialized into JSON
            completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Failed to encode post data to JSON"])))
        }
    } else {
        // Handle the error where the URL couldn't be created.
        completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
    }
}
