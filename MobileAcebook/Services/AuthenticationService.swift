//
//  AuthenticationService.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//
import Foundation
class AuthenticationService: AuthenticationServiceProtocol {
    
    
    func signUp(user: NewUser ) -> Bool {
        var results: SingUpResult?
        let url = URL(string: "http://localhost:3000/users")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters = ["email": user.email,
                          "password": user.password,
                          "username": user.username,
                          "imgurl": user.imgurl]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Invalid response")
                    return
                }
                
                if let data = data {
                    do {
                        let decodedResponse = try JSONDecoder().decode(SingUpResult.self, from: data)
                        DispatchQueue.main.async {
                            results = decodedResponse
                            print(decodedResponse.message) // Accessing message from decoded response
                            
                            
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }
            
            task.resume()
        } catch {
            print("Error: \(error)")
        }
        return true // placeholder
    }
    
    func signIn(user: User, completion: @escaping (Result<Token, Error>) -> Void) {
            let url = URL(string: "http://localhost:3000/tokens")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let parameters = ["email": user.email,
                              "password": user.password]
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse,
                          (200...299).contains(httpResponse.statusCode) else {
                        completion(.failure(NetworkError.invalidResponse))
                        return
                    }
                    
                    if let data = data {
                        do {
                            let decodedResponse = try JSONDecoder().decode(Token.self, from: data)
                            completion(.success(decodedResponse))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                }
                
                task.resume()
            } catch {
                completion(.failure(error))
            }
        }
}

enum NetworkError: Error {
    case invalidResponse
}
