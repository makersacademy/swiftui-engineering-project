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
    
    @ObservedObject var authService = AuthenticationService()

    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
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
                    
                    VStack(alignment: .leading, spacing: 15) {
                        TextField("", text: self.$email, prompt: Text("Email").foregroundColor(.white))
                            .padding()
                            .background(.black)
                            .cornerRadius(20.0)
                            .foregroundColor(.white)
                        
                        SecureField("", text: self.$password, prompt: Text("Password").foregroundColor(.white))
                            .padding()
                            .background(.black)
                            .cornerRadius(20.0)
                            .foregroundColor(.white)
                    }.padding([.leading, .trailing], 27.5)
                    
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
                    Divider()
                    
                    VStack{
                        Text("Don't have an account?").bold()
                        
                        Button("Click here"){
                            //Redirects to sign up
                        }.foregroundColor(.white)
                        .frame(width: 100, height: 30)
                        .background(Color.black)
                        .cornerRadius(15.0)
                        .accessibilityIdentifier("clickHereButton")
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $isAuthenticated) {
            // This will present the PostPageView when isAuthenticated becomes true
            //PostPageView()
            Button("Logout") {
                       logout()
                   }
                   .font(.headline)
                   .foregroundColor(.white)
                   .frame(width: 300, height: 50)
                   .background(Color.red)
                   .cornerRadius(15.0)
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
            if let data = data, let token = String(data: data, encoding: .utf8) {
                if isValidToken(token) {
                    print("Authentication token: \(token)")
                    isAuthenticated = true
                } else {
                    isAuthenticated = false
                    print("Invalid token: Authentication failed")
                }
            }
        }.resume()
    }
    
    private func isValidToken(_ token: String) -> Bool {
        
        return token.count > 50
    }
    
    private func logout() {
        authService.logout() // Clear user session
        isAuthenticated = false // Update UI to reflect logged out state
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}

