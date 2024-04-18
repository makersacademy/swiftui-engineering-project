//
//  WelcomePageView.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 30/09/2023.
//

import SwiftUI

struct WelcomePageView: View {
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Spacer()
                    
                    Text("Welcome to\n Pawbook!")
                        .font(.largeTitle)
                        .padding(.bottom, 25)
                        .accessibilityIdentifier("welcomeText")
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.50, green: 0.71, blue: 0.71))
                        .bold()
                    Spacer()
                    
                    Image("paw-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 130, height: 130)
                        .accessibilityIdentifier("paw-logo")
                    Spacer()
                    
                    NavigationLink(destination: LoginPageView()){
                        Text("Login")
                            .frame(width: 250, height: 40)
                            .background(Color(red: 0x50/255, green: 0xB7/255, blue: 0xB7/255))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .accessibilityIdentifier("loginButton")
                    }
                    NavigationLink(destination: SignUpPageView()){
                        Text("Sign Up")
                            .frame(width: 250, height: 40)
                            .background(Color(red: 0x50/255, green: 0xB7/255, blue: 0xB7/255))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .accessibilityIdentifier("signUpButton")
                    }
                    
                    Spacer()
                }
            }
        }}
}

struct WelcomePageView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePageView()
    }
}
