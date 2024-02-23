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
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjVkNjIyOWM3MWJjZjlkMWZkMTQ2ZjM5IiwiaWF0IjoxNzA4NTMyMzk1LCJleHAiOjE3MDg5NjQzOTV9.X8EZfJi0Ay4LAj7TrL-gey3w3PpvYRt5lJv-r0qeFp4" // temporary token only used locally, will be saved in separated gitignored file later on
    
    func fetchUser(completion: @escaping (UserData?, Error?) -> Void) {
        // Using a hardcoded ID (as an example)
        fetchUserById(userId: "65d88120c21fa47996095264", completion: completion)
    }

    func fetchUserById(userId: String, completion: @escaping (UserData?, Error?) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:8080/posts/\(userId)") else {
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
            
            if let data = data, let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON response: \(jsonString)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                completion(nil, nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(UserResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(responseData.ownerData, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }.resume()
    }
}

