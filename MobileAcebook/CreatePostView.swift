//
//  CreatePostView.swift
//  MobileAcebook
//
//  Created by Si on 21/02/2024.
//

import SwiftUI
import Foundation

struct CreatePostView: View {
    @State private var message: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter message here", text: $message)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Create Post") {
                createPost(message: message)
            }
        }
        .padding()
    }
    
    func createPost(message: String) {
        guard let url = URL(string: "http://127.0.0.1:8080/posts") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = retrieveTokenFromKeychain()?.token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            print("Failed to retrieve token from keychain.")
            return
        }
        
        let postData: [String: Any] = ["message": message]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postData)
        } catch {
            print("Error encoding post data: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Corrected scope for httpResponse
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 201 {
                    DispatchQueue.main.async {
                        print("Post created successfully.")
                    }
                } else {
                    print("Failed to create post. Status Code: \(httpResponse.statusCode)")
                }
            } else {
                print("Error during URLSession data task: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
}


struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView()
    }
}


