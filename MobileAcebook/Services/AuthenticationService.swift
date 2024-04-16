
import Foundation

class AuthenticationService: AuthenticationServiceProtocol {
    
    func signUp(user: User, completion: @escaping (Bool, String?) -> Void) {
        let url = URL(string: "http://localhost:3000/users")! 
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(user)
        } catch {
            completion(false, "Failed to encode user data")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                completion(false, "Failed to register user")
                return
            }
            
            if let error = error {
                completion(false, "Request error: \(error.localizedDescription)")
                return
            }
            
            completion(true, nil)
        }

    func login(email: String, password: String, completion: @escaping (Bool, String?, String?) -> Void) {
        let url = URL(string: "http://localhost:3000/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
        let loginDetails = ["email": email, "password": password]
    
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: loginDetails, options: [])
        } catch {
            completion(false, "Failed to encode login data", nil)
            return
        }
    
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                completion(false, "Failed to log in", nil)
                return
        }
        
        if let error = error {
            completion(false, "Request error: \(error.localizedDescription)", nil)
            return
        }
        
        do {
            if let tokenDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String],
                let token = tokenDict["token"] {
                    self.currentToken = token  // Save the token in-memory
                    completion(true, nil)
                } else {
                    completion(false, "Token not found")
                }
            } catch {
                completion(false, "Error decoding response")
    }
        task.resume()
    }

    func fetchProtectedData(completion: @escaping (Bool, Data?) -> Void) {
        guard let token = currentToken else {
            completion(false, nil)
            return
        }
        
        let url = URL(string: "http://localhost:3000/protected")!
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(false, nil)
                return
            }

            completion(true, data)
        }
        task.resume()
    }
}
}

