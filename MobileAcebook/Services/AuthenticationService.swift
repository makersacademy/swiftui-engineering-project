//
//  AuthenticationService.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

import Foundation

class AuthenticationService: ObservableObject, AuthenticationServiceProtocol {
    
    func signUp(user: User, completion: @escaping (Bool, Error?) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:8080/")?.appendingPathComponent("users") else {
            completion(false, nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            let userData = try encoder.encode(user)
            request.httpBody = userData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(false, error)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    completion(false, nil)
                    return
                }
                
                completion(true, nil)
            }.resume()
        } catch {
            completion(false, error)
        }
    }
    
    func LogIn(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:8080/tokens") else {
            completion(false, nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let credentials = [
            "email": email,
            "password": password
        ]
        
        do {
            let encoder = JSONEncoder()
            let userData = try encoder.encode(credentials)
            request.httpBody = userData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(false, error)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    completion(false, nil)
                    return
                }
                
                completion(true, nil)
            }.resume()
        } catch {
            completion(false, error)
        }
    }
}



