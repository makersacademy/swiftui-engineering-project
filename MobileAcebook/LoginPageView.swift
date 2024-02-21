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
    @State private var isNavigationActive: Bool = false
    @State private var errorMessage: String?
    
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
                    Task {
                        do {
                            try await loginViewModel.logIn(email: emailAddress, password: password)
                            isNavigationActive = true
                            
                        } catch {
                            errorMessage = error.localizedDescription
                            isNavigationActive = false
                        }
                    }
                    
                }.background(NavigationLink(destination: HomePageView(), isActive: $isNavigationActive) { EmptyView() })
               
            }
            
            if let error = errorMessage {
                Text(error)
                    .foregroundColor(.red)
                
            }
           
        }
        .environmentObject(loginViewModel)
                
        }

    }
    
    struct LoginPageView_Previews: PreviewProvider {
        static var previews: some View {
            LoginPageView()
        }
    }
        





