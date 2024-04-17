//
//  PostsService.swift
//  MobileAcebook
//
//  Created by Alannah Lawlor on 16/04/2024.
//


import Foundation

class APIService: PostService {
    func createPost(token: String, message: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:3000/posts") else {
            completion(.failure(PostAPIError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // Create JSON body
        let jsonBody: [String: Any] = ["message": message]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonBody, options: [])
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }

        // Set headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        // Perform the network request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle the response and errors
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(PostAPIError.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(PostAPIError.invalidData))
                return
            }

            do {
                // Parse JSON response
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let newToken = json["token"] as? String {
                    completion(.success(newToken))
                } else {
                    completion(.failure(PostAPIError.invalidData))
                }
            } catch {
                completion(.failure(error))
            }
        }

        task.resume() // Don't forget to resume the task
    }
    
    func getPosts(JWTtoken: String, completion: @escaping (Result<PostAPIResponse, PostAPIError>) -> Void) {
        guard let url = URL(string: "http://localhost:3000/posts") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(JWTtoken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            do {
                let apiResponse = try decoder.decode(PostAPIResponse.self, from: data)
                completion(.success(apiResponse))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        
        task.resume()
    }
}
