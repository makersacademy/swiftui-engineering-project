//
//  AuthenticationService.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//
import Foundation
class AuthenticationService: AuthenticationServiceProtocol {

    
    func signUp(user: User ) -> Bool {
        var results: SignupResult?
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
                        let decodedResponse = try JSONDecoder().decode(SignupResult.self, from: data)
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
    
    func signIn(user: LoginUser) -> Bool {
            var results:Token?
            let url = URL(string: "http://localhost:3000/tokens")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
        let parameters = ["email": user.email,
                          "password": user.password,
                              ]
            
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
                            let decodedResponse = try JSONDecoder().decode(Token.self, from: data)
                            DispatchQueue.main.async {
                                results = decodedResponse
                                print(decodedResponse.message) // Accessing message from decoded response
                                print(decodedResponse.token)

                                
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
        return true
    }
}

