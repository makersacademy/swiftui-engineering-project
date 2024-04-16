//
//  LogInView.swift
//  MobileAcebook
//
//  Created by Samuel Draper on 16/04/2024.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isLoggingIn = false
    @State private var loginSuccess = false
    @State private var loginMessage = ""

    var body: some View {
        VStack {
            TextField("Username", text: $username)
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
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
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
