//
//  AuthenticationService.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

import Foundation
class AuthenticationService: AuthenticationServiceProtocol {
  func signUp(user:User) async throws {
      let payload: [String: Any] = [
        "email": user.email,
        "password": user.password,
        "username": user.username
      ]
      let url = URL(string: "http://localhost:3000/users")!
      var request = URLRequest(url: url)
      request.httpMethod = "POST"
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      let jsonData = try JSONSerialization.data(withJSONObject: payload)
      request.httpBody = jsonData
      let (data, response) = try await URLSession.shared.data(for: request)
      guard let httpResponse = response as? HTTPURLResponse else {
        throw NSError(domain: "InvalidResponse", code: 0, userInfo: nil)
      }
      if httpResponse.statusCode == 201 {
        return
      } else {
        throw NSError(domain: "HTTPError", code: httpResponse.statusCode, userInfo: ["message": "Received status \(httpResponse.statusCode) when signing up. Expected 201"])
      }
    }
  }
