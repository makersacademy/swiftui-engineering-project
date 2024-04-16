
import Foundation

protocol AuthenticationServiceProtocol {
    func signUp(user: User, completion: @escaping (Bool, String?) -> Void)
}

struct User: Codable {
    let username: String
    let password: String
    let email: String
    let imgUrl: String
}

class AuthenticationService: AuthenticationServiceProtocol {
    func signUp(user: User, completion: @escaping (Bool, String?) -> Void) {
        let url = URL(string: "http://localhost:3000/users")! // Use http instead of https if you're not setup for SSL on local
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
        task.resume()
    }
}
