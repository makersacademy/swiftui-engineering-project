//
//  LogInView.swift
//  MobileAcebook
//
//  Created by Samuel Draper on 16/04/2024.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggingIn = false
    @State private var loginSuccess = false
    @State private var loginMessage = ""

    var body: some View {
        VStack {
            Spacer()

            Text("Welcome back to Fakebook!")
                .font(.largeTitle)
                .padding(.bottom, 20)
                .multilineTextAlignment(.center)
                .accessibilityIdentifier("welcomeBackText")

            Spacer()
            
            
            TextField("Email", text: $email)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Password", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if loginSuccess {
                Text(loginMessage)
                    .foregroundColor(.green)
            } else {
                Text(loginMessage)
                    .foregroundColor(.red)
            }

            Button(action: login) {
                Text("Log In")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
                .frame(height: 200)
        }
        .padding()
        .alert(isPresented: $isLoggingIn) {
            Alert(title: Text("Log In"), message: Text("Logging in..."), dismissButton: .default(Text("OK")))
        }
    }

    func login() {
        // Leave empty for now
    }
}
