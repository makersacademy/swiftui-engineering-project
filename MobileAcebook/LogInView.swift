//
//  LogInView.swift
//  MobileAcebook
//
//  Created by Ami Day on 09/10/2023.
//

import Foundation
import SwiftUI
import Combine


struct LogInView: View {
    @State private var userModel = User(email: "", password: "")
    @State private var loggedIn = false
    
    private func onEmailInputChanged(changedEmail: String) {
        userModel.email = changedEmail
        print("changed email: \(userModel.email)")
    }
    
    private func onPasswordInputChanged(changedPassword: String) {
        userModel.password = changedPassword
        print("changed password: \(userModel.password)")
    }
    let authenticationService = AuthenticationService()
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
                    
                    Spacer()
                    LabeledContent {
                        TextField("Email", text: $userModel.email).textInputAutocapitalization(.never)
                    } label: {
                        Text("Email")
                    }.onChange(of: userModel.email, perform: onEmailInputChanged)
                    
                    LabeledContent {
                        TextField("Password", text: $userModel.password).textInputAutocapitalization(.never)
                    } label: {
                        Text("Password")
                    }.onChange(of: userModel.password, perform: onPasswordInputChanged)
                    
                    
                    Button(action: {
                        var response = authenticationService.login(user: userModel) { isSuccess in
                            if isSuccess {
                                loggedIn = true
                            }
                        }
                    }) {
                        Text("Login")
                    }
                    .accessibilityIdentifier("LoginButton")
                    
                    NavigationLink(destination: PostsView().navigationBarBackButtonHidden(true), isActive: $loggedIn) { EmptyView() }
                    
                    Button("Sign Up") {
                        // TODO: sign up logic
                    }
                    .accessibilityIdentifier("signUpButton")
                    
                }
                
                Spacer()
            }
        }
    }
    
    struct LogInView_Previews: PreviewProvider {
        static var previews: some View {
            LogInView()
        }
    }
}
