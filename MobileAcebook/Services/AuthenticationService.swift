//
//  AuthenticationService.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//
import Foundation



class AuthenticationService: AuthenticationServiceProtocol {
    struct Response: Codable {
        let message : String
    }

    func signUp(user: User) -> Bool {
        guard let url = URL(string: "http://localhost:3000/users")  else {return false}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = user
        urlRequest.httpBody = try? JSONEncoder().encode(user)        
        let task = URLSession.shared.dataTask(with : urlRequest) {data, response, error in
            guard let data = data else {return}
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(response)
                print("User created successfully")
            }
            catch {
                print(error)
            }
        }
        task.resume()
        return true
    }
    
    func login(userLogin: UserLogin) -> Bool {
        guard let url = URL(string: "http://localhost:3000/tokens")  else {return false}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = userLogin
        urlRequest.httpBody = try? JSONEncoder().encode(userLogin)
        let task = URLSession.shared.dataTask(with : urlRequest) {data, response, error in
            guard let data = data else {return}
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("Valid user")
                print(response)
            }
            catch {
                print(error)
            }
        }
        task.resume()
        return true
    }
    
    

}

