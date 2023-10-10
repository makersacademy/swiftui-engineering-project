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
            print("-----> in onEmailInputChanged: \(changedEmail) ")
        }
    
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
                
                TextField("Email", text: $userModel.email)
                     .onChange(of: userModel.email, perform: onEmailInputChanged)
                
                NavigationLink(destination: LogInView()) {
                    Text("Login")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }
                
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
