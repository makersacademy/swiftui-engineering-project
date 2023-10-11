//
//  SignupPageService.swift
//  MobileAcebook
//
//  Created by Alice Birkett on 10/10/2023.
//

import SwiftUI

class SignupService {
    let email: String
    let username: String
    let password: String
    let password2: String
    let avatar: String?
    
    init(email: String, username: String, password: String, password2: String, avatar: String?) {
        self.email = email
        self.username = username
        self.password = password
        self.password2 = password2
        self.avatar = avatar
    }
    
    func createAccount () -> Void {
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/users")!)
        
        request.httpMethod = "POST"
        
        let user = User(email: email, username: username, password: password, avatar: nil)
        
        guard let jsonResultData = try? JSONEncoder().encode(user) else {
            print("data not found")
            return
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonResultData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            print(response)
        }
        task.resume()
    }
}

