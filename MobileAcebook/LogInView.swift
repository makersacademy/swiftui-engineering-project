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
                  TextField("Email", text: $userModel.email)
                } label: {
                  Text("Email")
                }.onChange(of: userModel.email, perform: onEmailInputChanged)
                
                LabeledContent {
                  TextField("Password", text: $userModel.password)
                } label: {
                  Text("Password")
                }.onChange(of: userModel.password, perform: onPasswordInputChanged)
                
                
                Button(action: {authenticationService.login(user: userModel)}) {
                    // TODO: login logic
                    Text("login")
                   
                }
                .accessibilityIdentifier("LoginButton")
                
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
