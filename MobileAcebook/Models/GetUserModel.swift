//
//  UserPageViewModel.swift
//  MobileAcebook
//
//  Created by Dan Gullis on 22/02/2024.
//

import SwiftUI


class GetUserModel: ObservableObject {

    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var user: User?
    
    var apiToken: String?
        
    init() {
        loadApiToken()
       }
        
        
    func loadApiToken() {
        do {
            apiToken = try KeychainHelper.loadToken(account: "default")
        } catch {
            print("failed to load token")
        }
    }
    
    
    func getUser(userId: String, completion: @escaping (Result<User, Error>)-> Void) {
        
        guard let url = URL(string: "http://127.0.0.1:8080/users/?user_id=\(userId)"), let apiToken = apiToken else {
            return
        }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            
        guard let data = data, error == nil else {
                    DispatchQueue.main.async {
                        self.errorMessage = error?.localizedDescription ?? "Unknown error"
                    }
                    return
                }

            do {
                print("data", data)
                let decodedUser = try JSONDecoder().decode(GetUserResponse.self, from: data)
                print("decoded user", decodedUser)
          
                // ? don't need
                DispatchQueue.main.async {
//                    self.user = decodedUser.user
                    completion(.success(decodedUser.user))
                }
                
//                completion(.success(decodedUser.user))
    
            } catch {
                print("Error decoding JSON: \(error)")
                DispatchQueue.main.async {
                    self.errorMessage = "Error decoding JSON: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
    
}
