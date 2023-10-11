//
//  AuthenticationService.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//
import Foundation

class AuthenticationService: AuthenticationServiceProtocol {
    func signUp(user: User) -> Bool {
        // Logic to call the backend API for signing up
        return true // placeholder
    }
    
    func login(user: User, completion: @escaping (Bool) -> Void) {
        var request = URLRequest(url: URL(string: "http://localhost:8080/tokens")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(user)
            request.httpBody = jsonData

            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                // Handling the response data, if any
                var isSuccess = false

                if let data = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        print("Response: \(jsonResponse)")

                        if let message = jsonResponse?["message"] as? String, message == "OK" {
                            // If the response message is "Email not found", login is unsuccessful
                            isSuccess = true
                        }
                    } catch {
                        // Handle JSON parsing errors, if any
                        print("Error parsing JSON: \(error)")
                    }
                }

                // Calling the completion handler with the login result (true for successful, false for unsuccessful)
                completion(isSuccess)
            }

            task.resume()
        } catch {
            // Handle encoding errors, if any
            print("Error encoding user object: \(error)")
            completion(false) // Calling the completion handler with false in case of an error
        }
    }

    
    
//    func login(user: User) -> Bool {
//        
//        var request = URLRequest(url: URL(string: "http://localhost:8080/tokens")!)
//        request.httpMethod = "POST"
//        var res: [String: Any]? = ["message": ""]
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        var ans = false
//
//        let jsonEncoder = JSONEncoder()
//        do {
//            let jsonData = try jsonEncoder.encode(user)
//            request.httpBody = jsonData
//
//            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//                // Handle response here
//                
//                 if let data = data {
//                    do {
//                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                        print("Response: \(jsonResponse)")
//                        res = jsonResponse
//                        
//                        
//                    } catch {
//                        print("Error parsing JSON: \(error)")
//                    }
//                    
//                }
//            }
//    
//            task.resume()
//        } catch {
//            print("Error encoding user object: \(error)")
//            
//        }
//        return ans
//        
//        if let message = res?["message"] as? String, message == "Email not found" {
//            print("yhukh")
//            return false
//        }else {
//            print(res?["message"])
//            print("working")
//            return true
//        }
//        
//      
////
//    }
//    
    
}
