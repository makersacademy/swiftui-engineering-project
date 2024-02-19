
import SwiftUI

struct SignUpDetails {
    var username: String
    var email: String
    var password: String
}

struct SignUpPageView: View {
    @State private var signUpDetails = SignUpDetails(username: "", email: "", password: "")
    @State private var passwordConfirm = ""
    @State private var passwordsMatch = true
    @State private var formSubmitted = false

    
    func submitButton() {
        
        if let url = URL(string: "http://127.0.0.1:8080/users") {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let parameters = [
                "username": signUpDetails.username,
                "email": signUpDetails.email,
                "password": signUpDetails.password]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data, let result = String(data: data, encoding: .utf8) {
                    print(result)
                }
            }.resume()
            
        }
        else {
            print("Invalid URL")
        }
    }
    
    var body: some View {
        VStack {
            Text("Sign up to Acebook!")
            Form {
                TextField("Username", text: $signUpDetails.username)
                TextField("Email", text: $signUpDetails.email)
                TextField("Password", text: $signUpDetails.password)
                TextField("Confirm Password", text: $passwordConfirm)
                
                if !passwordsMatch {
                    Text("Passwords do not match").foregroundColor(.red)
                }
                
                Button("Submit") {
                    passwordsMatch = signUpDetails.password == passwordConfirm
                    if passwordsMatch {
                        submitButton()
                        formSubmitted = true

                        }

                    }
                
                Group {
                    if formSubmitted {
                                Text("Log in")
                                }
                            }
 

                }
            }

        }
    }
    
    struct SignupPageView_Previews: PreviewProvider {
        static var previews: some View {
            SignUpPageView()
        }
    }

