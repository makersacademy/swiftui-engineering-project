//
//  LoginPageView.swift
//  MobileAcebook
//
//  Created by Dan Gullis on 20/02/2024.
//

import SwiftUI

struct LoginPageView: View {
    @StateObject private var loginViewModel = LoginViewModel()
    
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    @State private var isLoginSucessful: Bool = false
    @State private var errorMessage: String?
    @State private var isTokenStored: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                
                TextField("email address", text: $emailAddress)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                
                SecureField("password", text: $password)
                    .textContentType(.password)
                
                Button("Log In") {
                    loginViewModel.logIn(email: emailAddress, password: password) { result in
                        switch result {
                        case .success:
                            isLoginSucessful = true
                        case .failure(let error):
                            errorMessage = error.localizedDescription
                            isLoginSucessful = false
                        }
                    }
                    
                }
                .background(NavigationLink(destination: HomePageView(), isActive: $isLoginSucessful) { EmptyView() })
                
                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                    
                }
            }
            .onAppear{
                do {
                    if let storedToken = try KeychainHelper.loadToken() {
                        isTokenStored = true
                    } else {
                        isTokenStored = false
                    }
                } catch {

                    print("Error loading token from keychain: \(error.localizedDescription)")
                }
                
                if isTokenStored {
                    isLoginSucessful = true
                }
            }
            
        } .environmentObject(loginViewModel)
    }
}
    
    
struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
    





