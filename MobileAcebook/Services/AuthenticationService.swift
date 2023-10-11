//
//  AuthenticationService.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//
import SwiftUI

class AuthenticationService: AuthenticationServiceProtocol {
    @EnvironmentObject var token: Token
    var userToken: String?
    
    func signUp(user: User) -> Bool {
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/users")!)
        request.httpMethod = "POST"
        let json: [String: Any] = ["email": user.email, "password": user.password]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if error != nil {
                print("I've got an error")
            }
        }
        task.resume()
        return true
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
                                if let userToken = jsonResponse?["token"] as? String {
                                                            // Store the token in a variable
//                                    self.userToken = token
//                                    print("My token is \(self.userToken)")
                                    self.token.content = jsonResponse?["token"] as! String
                                                        }
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
    
    func createPost(post: Post) -> Void {
        print("Bearer \(token.content)")
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/posts")!)
        request.httpMethod = "POST"
        let json: [String: Any] = ["message": post.message]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(self.userToken)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if error != nil {
                print("I've got an error")
            }
        }
        task.resume()
    }
    
//    func allPosts -> Void { // -> Array<Post>
//        let url = URL(string: "http://127.0.0.1:8080/posts")!
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let data = data {
//                do {
//                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                    print("Response: \(jsonResponse)")
//                    
//                    if let posts = jsonResponse?["posts"] as? String, posts == "OK" {
//                        // If the response message is "Email not found", login is unsuccessful
//                        
//                    }
//                } catch {
//                    // Handle JSON parsing errors, if any
//                    print("Error parsing JSON: \(error)")
//                }
//            }
//        }
//        task.resume()
//    }
    
}

