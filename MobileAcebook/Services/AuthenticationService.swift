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
   

    func signUp(user: User, completion: @escaping (Bool) -> Void){
        guard let url = URL(string: "http://localhost:3000/users")  else {
            completion(false)
            return
        }
        
        
        var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                urlRequest.httpBody = try JSONEncoder().encode(user)
            } catch {
                print("Error encoding user: \(error)")
                completion(false)
                return
            }
            
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                    completion(false)
                    return
                }
                
                if !(200...299).contains(httpResponse.statusCode) {
                    print("HTTP error: \(httpResponse.statusCode)")
                    completion(false)
                    return
                }
                
                do {
                    let jsonResponse = try JSONDecoder().decode(Response.self, from: data)
                    print("Response message: \(jsonResponse.message)")
                    
                    if jsonResponse.message != "Something went wrong" {
                        completion(true) // Signup successful
                    } else {
                        completion(false) // Signup failed
                    }
                } catch {
                    print("JSON decoding error: \(error)")
                    completion(false)
                }
            }
            
            task.resume()
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
