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
    @EnvironmentObject var token: Token
    
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
                    SignedUp = authenticationService.signUp(user: user)
                }) {
                    Text("SignUp")
                }
                .accessibilityIdentifier("SignUpButton")
                
                NavigationLink(destination: PostsView().environmentObject(token), isActive: $SignedUp) { EmptyView() }
                
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
