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
    private var service = AuthenticationService()
    
    
    var body: some View {
        NavigationView{
            VStack{
                Image("makers-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .accessibilityIdentifier("makers-logo")
                Text("Welcome back!")
                        TextField("Email", text:  $email)
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
                Button("Sign in") {
                    service.signIn(email:email, password: password) { (token, err) in
                        print(err.debugDescription)
                    }
                }
//                NavigationLink("Sign In", destination: FeedView())
            }
        }
    }
}

#Preview {
    SignInView()
}
