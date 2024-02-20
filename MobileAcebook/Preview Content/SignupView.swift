//
//  SignupView.swift
//  MobileAcebook
//
//  Created by Aisha Mohamed on 19/02/2024.
//

import Foundation
import SwiftUI

struct SignupView: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var authenticationService: AuthenticationServiceProtocol
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .padding()
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Email", text: $email)
                .padding()
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .keyboardType(.emailAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Password", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: signup) {
                Text("Sign Up")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Signup"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .background(Color.blue)
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
    }
}

struct SignupViewPage_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(authenticationService: AuthenticationService())
    }
}
