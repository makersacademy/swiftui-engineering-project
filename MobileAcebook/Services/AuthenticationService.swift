//
//  AuthenticationService.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//
import SwiftUI

class AuthenticationService: AuthenticationServiceProtocol {
    
    func signUp(user: User) -> Bool {
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/users")!)
        request.httpMethod = "POST"
        let json: [String: Any] = ["email": user.email, "password": user.password]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
        return true
        }
    
    
    }

