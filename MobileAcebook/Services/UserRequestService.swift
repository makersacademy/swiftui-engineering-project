//
//  UserRequestService.swift
//  MobileAcebookTests
//
//  Created by Cloud Spotter on 11/10/2023.
//

import Foundation

func signUp(username: String, email: String, password: String, avatar: String?, completion: @escaping (Result<Void, Error>) -> Void ) {
    if let url = URL(string: "http://127.0.0.1:8080/users") {
        print("Valid URL: \(url)")
        
        var request = URLRequest(url: url) // Move this line inside the if let block
        request.httpMethod = "POST"
        request.httpBody = "key=value".data(using: .utf8)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                let statusCode = httpResponse.statusCode
                completion(.failure(NSError(domain: "", code: statusCode, userInfo: nil)))
                return
            }
            
            completion(.success(()))
        }
        task.resume()
    }
}



