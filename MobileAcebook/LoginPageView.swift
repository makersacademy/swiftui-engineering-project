//
//  WelcomePageView.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 30/09/2023.
//

import SwiftUI

struct LoginPageView: View {
    @State private var username = ""
    @State private var password = ""
    @State var isShowingPassword: Bool = false
    
    var body: some View {
        NavigationView {
                
            VStack {
                Spacer()
                Text("Log in")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                VStack {
                    Text("Username")                    .frame(maxWidth: 250, alignment: .topLeading)
                    
                    TextField("", text: $username)
                        .frame(width: 250, height: 40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray)
                        )
                        .multilineTextAlignment(.center)
                        .accessibilityIdentifier("loginUsername")
                }.padding()
                VStack {
                    Text("Password")
                        .frame(maxWidth: 250, alignment: .topLeading)
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
                
                
                Button("Submit") {
                    guard !username.isEmpty && !password.isEmpty else { return }
                }
                .frame(width: 250, height: 40)
                .background(Color(red: 0x50/255, green: 0xB7/255, blue: 0xB7/255))
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
                
                Spacer()
                Spacer()
                Spacer()
                HStack(spacing:3){
                    Text("Don't have an account?")
                    NavigationLink(destination: SignUpPageView()){
                        Text("Sign up here")
                            .fontWeight(.bold)
                    }
                    
                    //add navigation to login
                }
                .padding()
            }
            
        }
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
