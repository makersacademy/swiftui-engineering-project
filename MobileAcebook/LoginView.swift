//
//  LoginView.swift
//  MobileAcebook
//
//  Created by Dan Gibson on 10/10/2023.
//

import SwiftUI

struct loginView: View {
    @State private var UserEmail: String = ""
    @State private var UserPassword: String = ""
    
    var body: some View {
        VStack{
            VStack{
                Text("Login")
                    .bold().font(.largeTitle)
                    .padding(.top, 50)
            }
            Spacer()
            VStack{
                Image("MageBook-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .accessibilityIdentifier("MageBook-logo")
            }
            Spacer()
            VStack{
                TextField("Enter your email address", text: $UserEmail)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 350)
                SecureField("Enter your password", text: $UserPassword)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 350)
                HStack{
                    Spacer()
                    Button("Login") {
                                            // TODO: sign up logic
                                        }
                                        .buttonStyle(.borderedProminent)
                                        .cornerRadius(20)
                                        .frame(width: 150, height: 50)
                                        .padding(.trailing, 90)
                                    }
                                }
                                .frame(width: 500)
            Text("Sign up here")
                .foregroundColor(.blue)
                            }
            .padding(.bottom, 50)
        }
    }

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        loginView()
    }
}
