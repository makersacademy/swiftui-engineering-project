


import Foundation
import SwiftUI

struct SignupView: View {
    @State private var username = ""
    @State private var usernameRequired = false
    @State private var email = ""
    @State private var emailRequired = false
    @State private var isEmailValid = false
    @State private var password = ""
    @State private var passwordRequired = false
    @State private var isPasswordValid = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isSignupSuccessful = false
    @State private var shouldNavigate = false
    var iconClick = true
    
    var authenticationService: AuthenticationServiceProtocol
    let authService = AuthenticationService()
    
    var body: some View {
        
            VStack {
                
                Spacer()
                Text("Acebook")
                    .font(.system(size: 76))
                    .padding(.bottom, 20)
                    .foregroundColor(.white)
                
                TextField("Username", text: $username)
                    .padding()
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .onChange(of: username, perform: { value in
                        usernameRequired = !username.isEmpty
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Email address", text: $email)
                    .padding()
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .keyboardType(.emailAddress)
                    .onChange(of: email, perform: { value in
                        emailRequired = !email.isEmpty
//                        isEmailValid = isValidEmail(email)
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                SecureField("Password", text: $password)
                    .padding()
                    .onChange(of: password, perform: { value in
                        passwordRequired = !password.isEmpty
                        isPasswordValid = isValidPassword(password)
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
               
                NavigationLink( destination: LoginPage(authenticationService: AuthenticationService()), isActive: $shouldNavigate){
                        EmptyView()
                }
                
                if isPasswordValid {
                    Text("Password valid")
                        .foregroundColor(.green)
                }
                
                Button(action: {signup()}) {
                    Text("Button - Sign Up")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(UIColor(rgb: 0x38548f)))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
            Spacer()

                HStack {
                    Text("Already have an account? Login")
                        .foregroundColor(.white)
                    NavigationLink(
                        destination: LoginPage(authenticationService: AuthenticationService()),
                        label: {
                            Text("HERE")
                                .foregroundColor(.white)
                                
                        }
                    )
                }
            }
            
            .padding()
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Signup"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .background(Color(UIColor(rgb: 0x4267B2)))
}
    
        private func signup() {
            let newUser = User(username: username, email: email, password: password)
            
            authenticationService.signUp(user: newUser) { success, error in
                if success {
                    print("Signup successful")
                    alertMessage = "Signup successful"
                    showAlert = true
                    
                } else {
                    print("Signup failed: \(error?.localizedDescription ?? "Unknown error")")
                    alertMessage = "Signup failed: \(error?.localizedDescription ?? "Unknown error")"
                    showAlert = true
                }
            }
            isSignupSuccessful = true
    }
    private func isValidPassword(_ password: String) -> Bool {
        let psswordRegex = "^(?=.*[!@£$%^&*.,])(?=.*[A-Z])(?=.*[0-9]).{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", psswordRegex).evaluate(with: password)
    }
    

}
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

struct SignupViewPage_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(authenticationService: AuthenticationService())
    }
}
