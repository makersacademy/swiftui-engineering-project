//
//  SignupView.swift
//  MobileAcebook
//
//  Created by Benjamin Pearl on 16/04/2024.
//

import Foundation
import SwiftUI

struct SignupView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var email = ""
    @State private var signingUp = false
    @State private var signUpSuccess = false
    @State private var signUpMessage = "" 

    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Email", text: $email)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Password", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            if signUpSuccess {
                Text(signUpMessage)
                    .foregroundColor(.green)
            } else {
                Text(signUpMessage)
                    .foregroundColor(.red)
            }

            Button(action: signUp) {
                Text("Sign Up")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
        .alert(isPresented: $isSigningUp) {
            Alert(title: Text("Sign Up"), message: Text("Signing up..."), dismissButton: .default(Text("OK")))
        }
    }

    func signUp() {
        let user = User(username: username, password: password, email: email, imgUrl: "assets/blank-profile-picture-973460_640.png")
        isSigningUp = true // Show signing up alert

        // Call AuthenticationService to sign up the user
        AuthenticationService().signUp(user: user) { success in
            DispatchQueue.main.async {
                isSigningUp = false // Dismiss signing up alert
                if success {
                    // Handle signup success
                    print("Signup successful")
                } else {
                    // Handle signup failure
                    print("Signup failed")
                }
            }
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
