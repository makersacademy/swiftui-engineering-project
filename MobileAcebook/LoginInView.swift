import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var showAlert = false
    @State private var loggedIn = false // Track login status
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Log In") {
                    let login = User(email: email, password: password)
                    let authenticate = AuthenticationService()
                    
                    authenticate.signIn(user: login) { result in
                        switch result {
                        case .success(let token):
                            // Handle successful login
                            saveToken(token)
                            // Navigate to PostView
                            loggedIn = true
                            showAlert = false // Reset alert flag
                            errorMessage = "" // Reset error message
                        case .failure(let error):
                            // Handle error
                            errorMessage = "Error: \(error.localizedDescription)"
                            showAlert = true // Show alert for error
                        }
                    }
                }
                .padding()
                
                NavigationLink(destination: PostView(), isActive: $loggedIn) {
                    EmptyView()
                }
                .hidden()
            }
            .navigationTitle("Log In")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func saveToken(_ token: Token) {
        // Store token securely (e.g., Keychain)
        // For demonstration purposes, storing in UserDefaults
        let defaults = UserDefaults.standard
        defaults.set(token.token, forKey: "AuthToken")
        defaults.synchronize()
        print("Token set from login: \(token.token)")
    }
    
    
}

    
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
        }
    }

