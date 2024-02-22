
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
    @State private var messages: [String] = []
    @State private var showInvalidEmailError = false
    
//    Email validation, requires a @ and a .c to become valid
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func validatePassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }

    
    func validateForm() -> Bool {
        messages = []
        if signUpDetails.username.isEmpty {
            messages.append("Username is empty")}
        
        if signUpDetails.email.isEmpty {
            messages.append("Email is empty")}
        
        if signUpDetails.password.isEmpty {
            messages.append("Password is empty")}
        
        return messages.count == 0
    }

    
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
                
                //                Error handling for passwords not matching
                if !passwordsMatch {
                    Text("Passwords do not match").foregroundColor(.red)}
                
//                Error handling for password validation
                
//                if isValidEmail(email: signUpDetails.email) {
//                    
//                } else {
//                    Text("Invalid email address").foregroundColor(.red)
//                }
//                
//                if !validatePassword(signUpDetails.password) {
//                    Text("password must be 8 characters long, and include at least one digit and character")
//                    
//                }
                
                Button("Submit") {
                    passwordsMatch = signUpDetails.password == passwordConfirm
                    if validateForm() {
//                        do something
                    }

                    
                    if passwordsMatch {
                        submitButton()
                    
                    }
                    
                  
                }
                ForEach(messages, id: \.self) {message in Text(message).foregroundColor(.red)}
//                }
                

 

                }
            }

        }
    }
    
    struct SignupPageView_Previews: PreviewProvider {
        static var previews: some View {
            SignUpPageView()
        }
    }

