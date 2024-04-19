import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var showAlert = false
    @State private var loggedIn = false // Track login status
    @State private var userToken: String = ""
    
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
                    let login = LoginUser(email: email, password: password)
                    let authenticate = AuthenticationService()
                    
                    authenticate.signIn(user: login) { result in
                        switch result {
                        case .success(let token):
                            // Handle successful login
                            userToken = token.token
                            // Navigate to PostView
                            loggedIn = true
                            showAlert = false // Reset alert flag
                            errorMessage = "" // Reset error message
                            email = ""
                            password = ""
                        case .failure(let error):
                            // Handle error
                            errorMessage = "Error: \(error.localizedDescription)"
                            showAlert = true // Show alert for error
                        }
                    }
                }
                .padding()
                
                NavigationLink(destination: PostView(token: $userToken, loggedIn: $loggedIn), isActive: $loggedIn) {
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
}

    
    

