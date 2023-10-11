//
//  SignUpView.swift
//  MobileAcebook
//
//  Created by Alina Ermakova on 09/10/2023.
//

import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var token: String? = nil
    private var service = AuthenticationService()
    @State private var loginStatus: String = ""
    
    var body: some View {
        VStack {
            Image("makers-logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .accessibilityIdentifier("makers-logo")
            Text("Welcome back!")
            TextField("Email", text: $email)
                .padding()
                .foregroundColor(.black)
                .frame(width: 303, height: 36)
                .background(.white)
                .cornerRadius(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .inset(by: 0.5)
                        .stroke(Color(red: 0.16, green: 0.16, blue: 0.16).opacity(0.5), lineWidth: 1)
                )
            SecureField(
                "Password",
                text: $password
            )
            .padding()
            .foregroundColor(.black)
            .frame(width: 303, height: 36)
            .background(.white)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .inset(by: 0.5)
                    .stroke(Color(red: 0.16, green: 0.16, blue: 0.16).opacity(0.5), lineWidth: 1)
            )
            Text(loginStatus)
                .foregroundColor(.red)
                .padding(.top, 8)
            Button("Sign in") {
                service.signIn(email: email, password: password) { (receivedToken, err) in
                    if let token = receivedToken {
                        self.token = token
                        UserDefaults.standard.set(token, forKey: "token")
                        loginStatus = "Login successful"
                    } else {
                        // No token received, check for user existence
                        if let error = err {
                            loginStatus = error.localizedDescription
                        } else {
                            loginStatus = "Invalid email or password"
                        }
                    }
                }
            }
            .padding()
            .disabled(token != nil)
            .opacity(token == nil ? 1.0 : 0.5)
            
            NavigationLink("",
                           destination: FeedView(),
                isActive: Binding<Bool>(
                    get: { self.token != nil },
                    set: { _ in }
                )
            )
            .opacity(token != nil ? 1.0 : 0.0)
        }
    }
}
struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
