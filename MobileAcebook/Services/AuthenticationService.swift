//
//  AuthenticationService.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//
import Foundation
class AuthenticationService {
    func signUp(user: User, completion: @escaping (Bool) -> Void) {
        let url = URL(string: "http://localhost:3000/users")! // Replace with your backend URL
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let encoder = JSONEncoder()
        do {
            let userData = try encoder.encode(user)
            request.httpBody = userData

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let _ = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                    completion(true) // Signup successful
                } else {
                    completion(false) // Signup failed
                }
            }.resume()
        } catch {
            completion(false) // Encoding error
        }
    }
}
