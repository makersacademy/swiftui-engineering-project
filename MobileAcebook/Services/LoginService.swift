//
//  LoginService.swift
//  MobileAcebook
//
//  Created by Alexander Wilson on 11/10/2023.
//

import Foundation

struct Item: Codable {
    var token: String
    var message: String
}

func loginAsync(email: String, password: String, completion: @escaping(Result<Void, Error>) -> Void) {
    
    if let url = URL(string: "http://127.0.0.1:8080/tokens") {
        print("Valid URL \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let userData: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        // Convert the dictionary to JSON data
        if let jsonData = try? JSONSerialization.data(withJSONObject: userData) {
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
            
                if let data = data {
                    let decoder = JSONDecoder()
                    if let items = try? decoder.decode(Item.self, from: data) {
                        UserDefaults.standard.set(items.token, forKey: "user-token")
                    }
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 201 {
                    let statusCode = httpResponse.statusCode
                    completion(.failure(NSError(domain: "", code: statusCode, userInfo: nil)))
                    return
                }
                completion(.success(()))
            }
            task.resume()
            //userdefault, box to store values and retrieve them
        } else {
            completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Failed to serialize user data to JSON"])))
        }
    } else {
        completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
    }
    
}


//class LoginService{
//    func loginAsync(email: String, password: String) async throws -> String {
//        // Setting up url to send the request to by using URL class, with an error message in case the url is invalid
//        let urlString = "http://127.0.0.1:8080/tokens"
//        guard let url = URL(string: urlString) else {
//            throw NSError(domain: "Invalid url", code: 400, userInfo: nil)
//        }
//
//        // Actual fetching of data using URLSession async method, await data being fetched from url
//        let (data, _) = try await URLSession.shared.data(from: url)
//
//        // Parsing of JSON data we get back by turning it into a string, in this case we are changing the token into a string to be returned by the function
//        guard let tokenJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
//              let token = tokenJSON["token"] as? String else {
//            throw NSError(domain: "Invalid token", code: 500, userInfo: nil)
//        }
//        // ^^^^This throws an error in case the parsing of JSON data fails
//        print(token)
//        return token
//    }
//}

//func signUp(email: String, password: String, username: String, image: String?, completion: @escaping (Result<Void, Error>) -> Void ) {
//  if let url = URL(string: "http://127.0.0.1:8080/users") { // could refactor for guard
//    print("Valid URL: \(url)")
//  } else {
//    print("Invalid URL")
//  }
//  var request = URLRequest(url: url)
//  request.httpMethod = "POST"
//  request.httpBody = "key=value".data(using: .utf8)
//  let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//    if let error = error {
//      completion(.failure(error))
//      return
//    }
//    if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
//      let statusCode = httpResponse.statusCode
//      completion(.failure(NSError(domain: "", code: statusCode, userInfo: nil)))
//      return
//    }
//    completion(.success(()))
//    }
//    task.resume()
//}
