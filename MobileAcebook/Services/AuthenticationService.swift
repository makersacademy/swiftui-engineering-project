//
//  AuthenticationService.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

import SwiftUI

class AuthenticationService: AuthenticationServiceProtocol {
    
    var userToken: String = ""
    var posts_array: Array<String> = []

    
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
                        
                        if let message = jsonResponse?["message"] as? String, message == "OK" {
                            // If the response message is "Email not found", login is unsuccessful
                            isSuccess = true
                            if let token = jsonResponse?["token"] as? String {
                                // Store the token in a variable
                                self.userToken = token
                                //                                print("3")
                            }
                        }
                    } catch {
                        // Handle JSON parsing errors, if any
                        print("Error parsing JSON: \(error)")
                    }
                }
                // Calling the completion handler with the login result (true for successful, false for unsuccessful)
                completion(isSuccess)
                //                print("5")
            }
            task.resume()
        } catch {
            // Handle encoding errors, if any
            print("Error encoding user object: \(error)")
            completion(false) // Calling the completion handler with false in case of an error
            //            print("5")
        }
        //        print("1")
    }
    
    func createPost(post: Post, token: Token) -> Void {
        print("Bearer \(token.content)")
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/posts")!)
        request.httpMethod = "POST"
        let json: [String: Any] = ["message": post.message]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token.content)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if error != nil {
                print("I've got an error")
            }
        }
        task.resume()
    }
    
    func allPosts(token: Token, completion: @escaping (Bool) -> Void) { // -> Array<Post>
        posts_array = []
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/posts")!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token.content)", forHTTPHeaderField: "Authorization")
        do {
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                var isSuccess = false
                print("my token is: ", token.content)
                if let data = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                        print("my json message is: ", jsonResponse)

                            // If the response message is "Email not found", login is unsuccessful
                            if let token = jsonResponse?["token"] as? String {
                                isSuccess = true
                                // Store the token in a variable
                                self.userToken = token
                                print("my new token is: ", token)
                            }
                        if let posts = jsonResponse?["posts"] as? Array<Any> {
                                // Store the token in a variable
                            for post in posts {
                                // Check if the current post is a dictionary
                                if let postDictionary = post as? [String: Any] {
                                    // Access the "message" key and print its value
                                    if let message = postDictionary["message"] as? String {
                                        print("Message: \(message)")
                                        self.posts_array.append("\n " + message)
                                    }
                                }
                            }
//                                for post in jsonResponse?["posts"]{
////                                    self.posts_array.append(post["message"])
//                                    
//                                }
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
            print("my task is ", task)
        }
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
                var token: String? = nil

                if let data = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        print("Response: \(jsonResponse)")

                        if let message = jsonResponse?["message"] as? String, message == "OK" {
                            // If the response message is "Email not found", login is unsuccessful
                            isSuccess = true
                            if let token = jsonResponse?["token"] as? String {
                                                        // Store the token in a variable
                                self.userToken = token
                                print(self.userToken)
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
                    
                    
//                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                    print("Response: \(jsonResponse)")
//                    
//                    if let posts = jsonResponse?["posts"] as? String, posts == "OK" {
//                        print("Posts are: ", posts)
//                    }
//                } catch {
//                    // Handle JSON parsing errors, if any
//                    print("Error parsing JSON: \(error)")
//                }
//            }
//        }
//        task.resume()
//        return "one \n two \n three"
//    }
//    
//}

