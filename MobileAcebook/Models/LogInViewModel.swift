//
//  LogInViewModel.swift
//  MobileAcebook
//
//  Created by Dan Gullis on 20/02/2024.
//

import SwiftUI

struct LoginResponse: Codable {
    var token: String
    var message: String
}

struct LoginError: Error {
    var localizedDescription: String
}

class LoginViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var successMessage: String?
    
    func logIn(email: String, password: String) async throws {
        let requestBody = ["email": email, "password": password]
        
        guard let encoded = try? JSONEncoder().encode(requestBody) else {
            throw LoginError(localizedDescription: "Failed to encode request body")
        }
        
        let url = URL(string: "http://127.0.0.1:8080/tokens")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                        case 201:
                            if let decodedResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) {
                                errorMessage=nil
                                successMessage = "Login successful"
                                print(decodedResponse)
                            }
                        case 401:
                        throw LoginError(localizedDescription: "email not found")
                           
                        case 402:
                    throw LoginError(localizedDescription: "incorrect password")
                        default:
                    throw LoginError(localizedDescription:  "Unhandled status code: \(httpResponse.statusCode)")
                        }
                    }
  
        } catch {
            throw LoginError(localizedDescription: "Log In failed: \(error.localizedDescription)")
        }
        
    }
    
}
