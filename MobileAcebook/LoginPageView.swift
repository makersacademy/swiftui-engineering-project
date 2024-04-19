//
//  WelcomePageView.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 30/09/2023.
//

import SwiftUI

struct LoginPageView: View {
    @State private var email = ""
    @State private var password = ""
    @State var isShowingPassword: Bool = false
    @State private var authToken = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var isLoggedIn = false
    
    @State private var loginError: String? = nil
    let authService = AuthenticationService()
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Log in")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                VStack {
                    Text("Email")                    .frame(maxWidth: 250, alignment: .topLeading)
                    
                    TextField("", text: $email)
                        .frame(width: 250, height: 40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray)
                        )
                        .multilineTextAlignment(.center)
                        .autocapitalization(. none)
                        .accessibilityIdentifier("loginEmail")
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
                
                NavigationLink(destination: FeedPageView(token: authToken), isActive: $isLoggedIn) {
                    Button("Submit") {
                        let user = UserLogin(email: email, password: password)
                        
                        authService.login(userLogin: user) {
                            success, token in
                            if success {
                                DispatchQueue.main.async {
                                    email = ""
                                    password = ""
                                    authToken = token
                                    isLoggedIn = true
                                    alertMessage = "Success!"
                                }
                                
                            } else {
                                showAlert = true
                                alertMessage = "Error logging in"
                            }
                            
                        }
                        
                    }
                    .frame(width: 250, height: 40)
                    .background(Color(red: 0x50/255, green: 0xB7/255, blue: 0xB7/255))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                    }
                    //.hidden()
                
                
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
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                    
                )}
            
        }
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
