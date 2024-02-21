//
// CreateUserViewModel.swift
// MobileAcebook
//
// Created by Joshua Bhogal on 20/02/2024.
//

import Foundation

func createUser(user: User, completion: @escaping (Result<Data, Error>) -> Void) {
  guard let url = URL(string: "http://127.0.0.1:8080/users") else {
      completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
      return
    }
  var request = URLRequest(url: url)
  request.httpMethod = "POST"
  request.addValue("application/json", forHTTPHeaderField: "Content-Type")
  do {
    let encoder = JSONEncoder()
    let jsonData = try encoder.encode(user)
    request.httpBody = jsonData
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      if let error = error {
        completion(.failure(error))
        return
      }
      guard let httpResponse = response as? HTTPURLResponse,
         (200...299).contains(httpResponse.statusCode) else {
        completion(.failure(NSError(domain: "Invalid HTTP Response", code: 0, userInfo: nil)))
        return
      }
      if let data = data {
        completion(.success(data))
      } else {
        completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
      }
    }
    task.resume()
  } catch {
    completion(.failure(error))
  }
}
