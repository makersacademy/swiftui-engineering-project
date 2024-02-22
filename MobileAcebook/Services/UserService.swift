//
//  UserService.swift
//  MobileAcebook
//
//  Created by Gabriela Ehrenbrink on 22/02/2024.
//

import Foundation


//struct UserResponse: Codable {
//    let users: [User]
//    let user: String?
//    let token: String
//}

struct UserData: Codable {
    let username: String
    let avatar: String
    let email: String
    let password: String
}

struct UserResponse: Codable {
    let ownerData: UserData
    let token: String
}

protocol UserServiceProtocol {
    func fetchUser(completion: @escaping (UserData?, Error?) -> Void)
}

class UserService: UserServiceProtocol, ObservableObject {
    func fetchUser(completion: @escaping (UserData?, Error?) -> Void) {
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MDg2MjIzOTksImV4cCI6MTcwOTA1NDM5OX0.Rw1yZ9O-0BiBYcY4qS2UucQHZkvOS7eL89HofUyuhF0" // temporary token only used locally, will be saved in separated gitignored file later on
        guard let url = URL(string: "http://127.0.0.1:8080/posts/65d782366b9025be365e88de") else {
            completion(nil, nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            // Print the raw JSON response as a string for debugging
            if let data = data, let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON response: \(jsonString)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                completion(nil, nil) // Consider creating a specific error to return here
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(UserResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(responseData.ownerData, nil)
                }
            } catch {
                print("Decoding error: \(error)")
                // If possible, print more detailed error info
                if let decodingError = error as? DecodingError {
                    switch decodingError {
                    case .dataCorrupted(let context), .keyNotFound(_, let context), .typeMismatch(_, let context), .valueNotFound(_, let context):
                        print(context.debugDescription)
                        print(context.codingPath.map { $0.stringValue }.joined(separator: " -> "))
                    @unknown default:
                        print("Unknown decoding error")
                    }
                }
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }.resume()
    }
}
