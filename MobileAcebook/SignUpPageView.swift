
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
    @State private var showAlert = false
    @State private var alertDismissed = false
    
    
    //    Email validation, requires a @ and a .c to become valid
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
//    Password validation, needs an @ symbol and .c to pass
    func validatePassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
//    Form validation, checking to make sure all forms are not empty, and if they are, showing error messages relating to empty field
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
        NavigationView {
            VStack {
                Text("Sign up to Acebook!")
                    .font(.largeTitle)
                    .padding(.bottom, 20)
                    .accessibilityIdentifier("welcomeText")
                Form {
                    TextField("", text: $signUpDetails.username, prompt: Text("Username").foregroundColor(.white))
                        .padding()
                        .background(Color.black)
                        .cornerRadius(20.0)
                        .foregroundColor(.white)
                        .autocapitalization(.none)
                    
                    TextField("", text: $signUpDetails.email, prompt: Text("Email").foregroundColor(.white))
                        .padding()
                        .background(Color.black)
                        .cornerRadius(20.0)
                        .foregroundColor(.white)
                        .autocapitalization(.none)
                    
                    SecureField("", text: $signUpDetails.password, prompt: Text("Password").foregroundColor(.white))
                        .padding()
                        .background(Color.black)
                        .cornerRadius(20.0)
                        .foregroundColor(.white)
                    
                    SecureField("", text: $passwordConfirm, prompt: Text("Confirm password").foregroundColor(.white))
                        .padding()
                        .background(Color.black)
                        .cornerRadius(20.0)
                        .foregroundColor(.white)
                    
                    //                Error handling for passwords not matching
                    if !passwordsMatch {
                        Text("Passwords do not match").foregroundColor(.red)}
                    
                    //                Error handling for email validation
                    if isValidEmail(email: signUpDetails.email) {}
                    else {
                        Text("Invalid email address").foregroundColor(.red)}
                    
                    //                error handling for password validation
                    if !validatePassword(signUpDetails.password) {
                        Text("Password must be 8 characters long,  and include at least one digit and letter")}
                    
                    Button("Submit") {
                        passwordsMatch = signUpDetails.password == passwordConfirm
                        if validateForm() && passwordsMatch {
                            showAlert = true
                            submitButton()}
                    }.font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.black)
                        .cornerRadius(15.0)
                        .accessibilityIdentifier("loginButton")
                        .alert(isPresented: $showAlert) {
                            
                            Alert(
                                title: Text("Success!"),
                                message: Text("Please log in"),
                                dismissButton: .default(Text("Lets go")) {
                                    alertDismissed = true
                                }
                            )
                        }
                    
                    if alertDismissed {
                        NavigationLink(destination: LoginPageView()) {
                            Text("Log in")
                                .foregroundColor(.white)
                                .frame(width: 100, height: 30)
                                .background(Color.black)
                                .cornerRadius(15.0)
                                .accessibilityIdentifier("clickHereButton")
                            
                        }
                        //                    Looping through the form validator to show what field has not been filled out
                        ForEach(messages, id: \.self) {message in Text(message).foregroundColor(.red)}
                        
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
}
