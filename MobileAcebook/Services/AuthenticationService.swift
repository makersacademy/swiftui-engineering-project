import Foundation

class AuthenticationService: ObservableObject, AuthenticationServiceProtocol {
    private let tokenKey = "authToken" // Key for storing token in UserDefaults
    
    func getToken(completion: @escaping (String?) -> Void) {
        if let token = UserDefaults.standard.string(forKey: tokenKey) {
            completion(token)
        } else {
            completion(nil)
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Bool, String?, String?) -> Void) {
        let url = URL(string: "http://localhost:3000/tokens")!
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
            if let error = error {
                completion(false, "Request error: \(error.localizedDescription)", nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(false, "Invalid response", nil)
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(false, "HTTP error: \(httpResponse.statusCode)", nil)
                return
            }
            
            guard let data = data else {
                completion(false, "No data received", nil)
                return
            }
            
            do {
                guard let tokenDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String] else {
                    completion(false, "Invalid token data", nil)
                    return
                }
                
                guard let token = tokenDict["token"] else {
                    completion(false, "Token not found in response", nil)
                    return
                }
                
                // Store token in UserDefaults
                UserDefaults.standard.set(token, forKey: self.tokenKey)
                UserDefaults.standard.synchronize()
                
                completion(true, nil, token)  // Pass token back through completion handler
            } catch {
                completion(false, "Error decoding response: \(error.localizedDescription)", nil)
            }
        }
        task.resume()
    }
    
    // Implementing AuthenticationServiceProtocol method
    func signUp(user: User, completion: @escaping (Bool, String?) -> Void) {
        // Your implementation for signing up a user
        // This method is required by the AuthenticationServiceProtocol
    }

}
