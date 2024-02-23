//
//  LoginPageView.swift
//  MobileAcebook
//
//  Created by Holly Page on 19/02/2024.
//

import SwiftUI

struct LoginPageView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var isAuthenticated = false
    @State private var showEmailError = false
    @State private var showPasswordError = false
    
    @ObservedObject var authService = AuthenticationService()
    
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    
                    Text("Acebook")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(.black)
                        .cornerRadius(30.0)
                        .accessibilityIdentifier("welcomeText")
                    
                    Spacer()
                    
                    Image("makers-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .accessibilityIdentifier("makers-logo")
                    
                    Text("Please enter your details")
                        .font(.caption)
                        .bold()
                    
                    Spacer()
                    Spacer()
                    
                    
                    VStack(alignment: .leading, spacing: 15) {
                        TextField("", text: self.$email, prompt: Text("Email").foregroundColor(.white))
                            .padding()
                            .background(.black)
                            .cornerRadius(20.0)
                            .foregroundColor(.white)
                            .autocapitalization(.none)
                        
                        SecureField("", text: self.$password, prompt: Text("Password").foregroundColor(.white))
                            .padding()
                            .background(.black)
                            .cornerRadius(20.0)
                            .foregroundColor(.white)
                    }.padding([.leading, .trailing], 27.5)
                    
                    Spacer()
                    Spacer()
                    
                    Button("Login") {
                        login()
                    }.font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.black)
                        .cornerRadius(15.0)
                        .accessibilityIdentifier("loginButton")
                    
                    Spacer()
                    Spacer()
                    Divider()
                    
                    
                    VStack{
                        Text("Don't have an account?").bold()
                        
                        
                        NavigationLink(destination: SignUpPageView()){
                            Text("Click here")
                        }.foregroundColor(.white)
                            .frame(width: 100, height: 30)
                            .background(Color.black)
                            .cornerRadius(15.0)
                            .accessibilityIdentifier("clickHereButton")
                    }
                }
                if showEmailError { // Display email error message
                    Text("Email doesn't exist")
                        .foregroundColor(.red)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .offset(y: -100) // Adjust the position as needed
                } else if showPasswordError { // Display password error message
                    Text("Incorrect password")
                        .foregroundColor(.red)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .offset(y: -100) // Adjust the position as needed
                }
            }
        }
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $isAuthenticated) {
            // This will present the PostPageView when isAuthenticated becomes true
            NavigationTabView()
        }
        .onReceive(NotificationCenter.default.publisher(for: .logoutNotification)) { _ in
            // Present the welcome page when logout notification is received
            isAuthenticated = false // Set isAuthenticated to false to trigger presentation of welcome page
        }
    }
    
    private func login() {
        guard let url = URL(string: "http://127.0.0.1:8080/tokens") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters = ["email": email, "password": password]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters) else {
            print("Invalid parameters")
            return
        }
        
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    // Handle error, for example, show a general error message
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Invalid response")
                    // Handle error, for example, show a general error message
                    return
                }
                
                if httpResponse.statusCode == 201, let data = data, let token = String(data: data, encoding: .utf8) {
                    // Successful authentication
                    if isValidToken(token) {
                        print("Authentication token: \(token)")
                        saveTokenToKeychain(token: token)
                        isAuthenticated = true
                        print("Is Authenticated: \(isAuthenticated)")
                        // Clear input fields
                        email = ""
                        password = ""
                    } else {
                        print("Invalid token: Authentication failed")
                        // Handle error, for example, show a general error message
                    }
                } else if httpResponse.statusCode == 401 {
                    // Incorrect password
                    showEmailError = true
                    print("Email does not exist")
                } else if httpResponse.statusCode == 402 {
                    // Email doesn't exist
                    showPasswordError = true
                    print("Incorrect password")
                } else {
                    print("Unexpected status code: \(httpResponse.statusCode)")
                    // Handle error, for example, show a general error message
                }
            }
        }.resume()
    }
    
}



private func isValidToken(_ token: String) -> Bool {
    
    return token.count > 50
}

// Custom notification name for logout events
extension Notification.Name {
    static let logoutNotification = Notification.Name("LogoutNotification")
}


struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}

