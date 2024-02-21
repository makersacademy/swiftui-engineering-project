//
//  LogInViewModel.swift
//  MobileAcebook
//
//  Created by Dan Gullis on 20/02/2024.
//

import Foundation

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
    
    func logIn(email: String, password: String, completion: @escaping(Result<Void, LoginError>) -> Void) {
        let requestBody = ["email": email, "password": password]
        
        guard let encoded = try? JSONEncoder().encode(requestBody) else {
                  completion(.failure(LoginError(localizedDescription: "Failed to encode request body")))
                  return
              }
        
        let url = URL(string: "http://127.0.0.1:8080/tokens")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        
        URLSession.shared.uploadTask(with: request, from: encoded) {data, response, error in
            if let error = error {
                completion(.failure(LoginError(localizedDescription: "Log In failed: \(error.localizedDescription)")))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(LoginError(localizedDescription: "Unexpected response format")))
                return
            }
            
            switch httpResponse.statusCode {
                    case 201:
                if let data = data, let decodedResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) {
                            do {
                                try KeychainHelper.saveToken(decodedResponse.token)
                                self.errorMessage = nil
                                self.successMessage = "Login successful"
                                completion(.success(()))
                                } catch {
                                    completion(.failure(LoginError(localizedDescription: "Failed to save token: \(error.localizedDescription)")))
                                }
                        }
                    case 401:
                        completion(.failure(LoginError(localizedDescription: "Email not found")))

                    case 402:
                        completion(.failure(LoginError(localizedDescription: "Incorrect password")))

                    default:
                        completion(.failure(LoginError(localizedDescription: "Unhandled status code: \(httpResponse.statusCode)")))
                    }
            
        }.resume()
        
    }
    
}
