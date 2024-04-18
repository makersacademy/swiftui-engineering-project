//
//  AuthenticationService.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

import Foundation
class AuthenticationService: AuthenticationServiceProtocol {
    func signUp(user:User) async throws {
      let payload: [String: Any] = [
        "email": user.email,
        "password": user.password,
        "username": user.username
      ]
      let url = URL(string: "http://localhost:3000/users")!
      var request = URLRequest(url: url)
      request.httpMethod = "POST"
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      let jsonData = try JSONSerialization.data(withJSONObject: payload)
      request.httpBody = jsonData
      let (data, response) = try await URLSession.shared.data(for: request)
      guard let httpResponse = response as? HTTPURLResponse else {
        throw NSError(domain: "InvalidResponse", code: 0, userInfo: nil)
      }
      if httpResponse.statusCode == 201 {
        return
      } else {
        throw NSError(domain: "HTTPError", code: httpResponse.statusCode, userInfo: ["message": "Received status \(httpResponse.statusCode) when signing up. Expected 201"])
      }
    }
    
    func login(user: User, completion: @escaping (Result<String, Error>) -> Void) {
                let url = URL(string: "http://localhost:3000/tokens")!
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let body = [
                    "email": user.email,
                    "password": user.password
                ]
                
                request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                        completion(.failure(NSError(domain: "MobileAcebookApp", code: 0, userInfo: [NSLocalizedDescriptionKey: "Server responded with an error"])))
                        return
                    }
                    
                    guard let data = data else {
                        completion(.failure(NSError(domain: "MobileAcebookApp", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received from the server"])))
                        return
                    }
                    
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String], let token = json["token"] {
                            completion(.success(token))
                        } else {
                            completion(.failure(NSError(domain: "MobileAcebookApp", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response from the server"])))
                        }
                    } catch {
                        completion(.failure(error))
                    }
                }
                
                task.resume()
            }
}
