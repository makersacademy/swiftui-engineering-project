//
//  LoginView.swift
//  MobileAcebook
//
//  Created by Gabriela Ehrenbrink on 20/02/2024.
//

import Foundation
import SwiftUI

struct LoginPage: View {
    @State private var email = ""
    @State private var password = ""
    @State private var wrongEmail = 0
    @State private var wrongPassword = 0
    @State private var isLoginSuccessful = false
    
    var authenticationService: AuthenticationService

    
    var body: some View {
        NavigationView {
            ZStack{
                Color(red: Double(67) / 255.0,
                      green: Double(100) / 255.0,
                      blue: Double(157) / 255.0
                )
                .ignoresSafeArea()
                VStack {
                    Text("Acebook")
                        .font(.system(size: 70))
                        .bold()
                        .padding()
                        .foregroundColor(Color.white)
                    TextField("Email", text: $email)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongEmail))
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword))
                    
                    NavigationLink(
                        destination: SignupView(authenticationService: authenticationService),
                        label: {
                            Text("Sign Up")
                        }
                    )
                    .accessibilityIdentifier("signUpButton")
                    
                    Button("Login") {
                        authenticateUser(email: email, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width: 100, height: 50)
                    .background(Color(red: Double((0x254778 & 0xFF0000) >> 16) / 255.0, green: Double((0x254778 & 0x00FF00) >> 8) / 255.0, blue: Double(0x254778 & 0x0000FF) / 255.0))
                    .cornerRadius(10)
                    .bold()
                    
                    
                }
                
            }
            .navigationBarHidden(true)
        }
        
    }
    func authenticateUser(email: String, password: String) {
        authenticationService.LogIn(email: email, password: password) { success, error in
            if success {
                // Authentication succeeded, you can navigate to the next screen or perform other actions
                print("Authentication successful!")
            } else {
                // Authentication failed, update UI accordingly (e.g., show an error message)
                print("Authentication failed!")
            }
        }
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            LoginPage(authenticationService: AuthenticationService())
        }
    
    }

}
