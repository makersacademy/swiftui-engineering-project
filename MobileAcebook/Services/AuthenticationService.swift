//
//  AuthenticationService.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//
import Foundation

class AuthenticationService: AuthenticationServiceProtocol {
    
    struct SignInResponse: Codable {
        var token: String?
        var message: String
    }
    
    func signIn(email: String, password: String, completion: @escaping AuthCallback) {
        
        let urlString = "http://127.0.0.1:8080/tokens"
        guard let url = URL(string: urlString) else {
           completion(nil, NSError(domain: "Invalid URL", code: 400, userInfo: nil))
           return
       }
        
        let parameters = ["email": email, "password": password]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch let error {
            completion(nil, error)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        print(request.debug())
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                if let token = try? decoder.decode(SignInResponse.self, from: data) {
                    print(token)
                    completion(token.token, nil)
                } else {
                    print(error)
                    completion(nil, NSError(domain: "Invalid data", code: 500, userInfo: nil))
                }
            }
        }
        
        task.resume()
    }
    
    
    func signUp(user: User) -> Bool {
        // Logic to call the backend API for signing up
        return true // placeholder
    }
}

fileprivate extension URLRequest {
    func debug() {
        print("\(self.httpMethod!) \(self.url!)")
        print("Headers:")
        print(self.allHTTPHeaderFields!)
        print("Body:")
        print(String(data: self.httpBody ?? Data(), encoding: .utf8)!)
    }
}
