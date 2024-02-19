//
//  WelcomePageView.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 30/09/2023.
//

import SwiftUI

struct WelcomePageView: View {
    
    // remove these
    @State private var isLoggedIn = true
    @State private var showLoggedOutMessage = false
    var authService = AuthenticationService()
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                Text("Welcome to Acebook!")
                    .font(.largeTitle)
                    .padding(.bottom, 20)
                    .accessibilityIdentifier("welcomeText")
                
                Spacer()
                
                Image("makers-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .accessibilityIdentifier("makers-logo")
                
                Spacer()
                
                Button("Sign Up") {
                    // TODO: sign up logic
                }
                .accessibilityIdentifier("signUpButton")
                
                // move this to the relevant pages !!
                Button("Logout") {
                    authService.logout()
                    // isLoggedIn = false
                    showLoggedOutMessage = true
                }
                .accessibilityIdentifier("logout")
                
                Spacer()
            }
            .sheet(isPresented: $showLoggedOutMessage) {
                LogoutMessageView()
            }
        }
    }
    
    struct WelcomePageView_Previews: PreviewProvider {
        static var previews: some View {
            WelcomePageView()
        }
    }
}
