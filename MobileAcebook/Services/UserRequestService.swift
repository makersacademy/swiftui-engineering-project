//
//  UserRequestService.swift
//  MobileAcebook
//
//  Created by Alexander Wilson on 12/10/2023.

import Foundation

func signUp(username: String, email: String, password: String, avatar: String?, completion: @escaping (Result<Void, Error>) -> Void ) {
    if let url = URL(string: "http://127.0.0.1:8080/users") {
        print("Valid URL: \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Create a dictionary to represent the user data
        let userData: [String: Any] = [
            "username": username,
            "email": email,
            "password": password,
            "avatar": avatar ?? "" // Use empty string if avatar is nil
        ]
        
        // Convert the dictionary to JSON data
        if let jsonData = try? JSONSerialization.data(withJSONObject: userData) {
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 201 {
                    let statusCode = httpResponse.statusCode
                    completion(.failure(NSError(domain: "", code: statusCode, userInfo: nil)))
                    return
                }
                
                completion(.success(()))
            }
            task.resume()
        } else {
            completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Failed to serialize user data to JSON"])))
        }
    } else {
        completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
    }
}
