//
//  LoginView.swift
//  MobileAcebook
//
//  Created by philip hanlon on 15/04/2024.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""

    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Log In") {
             
            }
            .padding()
        }
        .navigationTitle("Log In")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

