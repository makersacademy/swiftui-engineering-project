//
//  GetPostsService.swift
//  MobileAcebook
//
//  Created by Amy McCann on 21/02/2024.
//

import Foundation

struct Item: Decodable {
    let user: User
    let posts: [Post]
}

class PostsView: ObservableObject {
    @Published var posts: [Post] = []
    var token = retrieveTokenFromKeychain()?.token
    
    func fetchPosts() {
        if let url = URL(string: "http://127.0.0.1:8080/posts") {
          var request = URLRequest(url: url)
          request.httpMethod = "GET"
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
          URLSession.shared.dataTask(with: request) { data, response, error in
              if let data = data, let result = try? JSONDecoder().decode(Item.self, from:data) {
                  DispatchQueue.main.async {
                      self.posts = result.posts
                  }
            }
          }.resume()
        } else {
          print("Invalid URL")
        }
    }
}

struct UserData: Decodable {
    let ownerData: User
}

class PostUser: ObservableObject {
    @Published var postOwner: User?
    var token = retrieveTokenFromKeychain()?.token
    
    func fetchPostUser(userId: String) {
        if let url = URL(string: "http://127.0.0.1:8080/posts/\(userId)") {
          var request = URLRequest(url: url)
          request.httpMethod = "GET"
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
          URLSession.shared.dataTask(with: request) { data, response, error in
              if let data = data, let result = try? JSONDecoder().decode(UserData.self, from:data) {
                  self.postOwner = result.ownerData
                  print(result.ownerData)
              }
          }.resume()
        } else {
          print("Invalid URL")
        }
    }
}
