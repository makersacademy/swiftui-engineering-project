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
    
    struct loginResponse: Codable {
        let message : String
        let token : String
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
    
//    func login(userLogin: UserLogin, completion: @escaping ((Bool, String) -> Void)) {
//        guard let url = URL(string: "http://localhost:3000/tokens")  else {
//            completion(false, "")
//            return
//        }
//        
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = "POST"
//        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        urlRequest.httpBody = try? JSONEncoder().encode(userLogin)
//        let task = URLSession.shared.dataTask(with : urlRequest) {data, response, error in
////            guard let data = data else {
////                completion(false, "")
////                return
//            guard let httpResponse = response as? HTTPURLResponse, let data = data else {
//                completion(false, "")
//                return
//            }
//            
//            if !(200...299).contains(httpResponse.statusCode) {
//               print("HTTP error: \(httpResponse.statusCode)")
//               completion(false, "")
//               return
//           }
//        }
//           
////        guard let httpResponse = response as? HTTPURLResponse, let data = data else {
////            completion(false, String)
////            return
////        }
//            
//        
//        
//            
//            do {
//                let response = try JSONDecoder().decode(loginResponse.self, from: data)
//                DispatchQueue.main.async {
//                    completion(true, response.token)
//                    print(response.token)
//                }
//            }
//            catch {
//                print(error)
//                completion(false, "")
//            }
//        }
//        task.resume()
////        return
//    }
//    
//    
    
    func login(userLogin: UserLogin, completion: @escaping (Bool, String) -> Void) {
        guard let url = URL(string: "http://localhost:3000/tokens") else {
            completion(false, "")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONEncoder().encode(userLogin)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
                // Handle network error or empty response
                completion(false, "")
                print(error!)
                return
            }
            
            // Check for HTTP status code
            guard (200...299).contains(httpResponse.statusCode) else {
                // Handle HTTP error
                print("HTTP error: \(httpResponse.statusCode)")
                completion(false, "")
                return
            }
            
            do {
                
                let response = try JSONDecoder().decode(loginResponse.self, from: data)
                DispatchQueue.main.async {
                    // If decoding succeeds, pass the token to the completion closure
                    completion(true, response.token)
                    print(response)
                    return
                }
            } catch {
                // Handle JSON decoding error
                print("JSON decoding error:", error)
                completion(false, "")
            }
        }
        
        task.resume()
    }


}
