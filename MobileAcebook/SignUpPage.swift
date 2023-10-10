//
//  WelcomePageView.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 30/09/2023.
//

import SwiftUI

struct SignUpView: View {
    @State private var authenticationService = AuthenticationService()
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var SignedUp = false
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("Sign Up")
                    .font(.largeTitle)
                    .padding(.bottom, 20)
                
                TextField("email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text:$password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    let user = User(email: email, password: password)
                    let response = authenticationService.signUp(user: user)
                    if response == true {
                        SignedUp = true
                    }
                }) {
                    Text("SignUp")
                }
                .accessibilityIdentifier("SignUpButton")
                
                NavigationLink(destination: WelcomePageView(), isActive: $SignedUp) { EmptyView() }
                
                Spacer()
            }
        }
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
