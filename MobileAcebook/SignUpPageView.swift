//
//  SignUpPageView.swift
//  MobileAcebook
//
//  Created by Venera Zhargakova on 16/04/2024.
//

import Foundation

import SwiftUI
struct SignUpPageView: View {
    @State private var email = ""
    @State private var fullName = ""
    @State private var password = ""
    @State var isShowingPassword: Bool = false

    //errors:
    @State private var emailError = ""
    //let authService: AuthenticationServiceProtocol
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Spacer()
                Spacer()
                Text("Sign Up")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                VStack(spacing:0) {
                    Text("Email Address")
                        .frame(maxWidth: 250, alignment: .topLeading)
                        .padding()
                    TextField("", text: $email)
                        .frame(width: 250, height: 40)
                        .multilineTextAlignment(.center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray)
                        )
                        .autocapitalization(. none)
                        .accessibilityIdentifier("email")
                    Text("Full Name")
                        .frame(maxWidth: 250, alignment: .topLeading)
                        .padding()
                    TextField("", text: $fullName)
                        .frame(width: 250, height: 40)
                        .multilineTextAlignment(.center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray)
                        )
                        .autocapitalization(. none)
                        .accessibilityIdentifier("Full Name")
                    Text("Password")
                        .frame(maxWidth: 250, alignment: .topLeading)
                        .padding()
                    VStack {
                    Group {
                        if isShowingPassword {
                            TextField("", text: $password)
                                .frame(width: 250, height: 40)
                                .multilineTextAlignment(.center)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray))
                        }else {
                            SecureField("", text: $password)
                            .frame(width: 250, height: 40)
                            .multilineTextAlignment(.center)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray))
                        }
                        }
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        
                        Button {
                            isShowingPassword.toggle()
                        } label: {
                            if isShowingPassword {
                                Text("Hide password")
                            } else {
                                Text("Show password")
                            }
                        }.padding()
                    }

                    VStack{
                        Button("Sign Up"){
                            //add logic here
                        }
                        .frame(width: 250, height: 40)
                        .background(Color(red: 0x50/255, green: 0xB7/255, blue: 0xB7/255))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .padding(.top, 40)
                    Spacer()
                    HStack(spacing:3){
                        Text("Already have an account?")
                        NavigationLink(destination: LoginPageView()){
                          Text("Login here")
                          .fontWeight(.bold)}
                      }
                }
            }
        }
    }
}
#Preview {
    SignUpPageView()
}







