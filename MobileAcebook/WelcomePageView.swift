//
//  WelcomePageView.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 30/09/2023.
//

import SwiftUI

struct WelcomePageView: View {
    var body: some View {
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
                    .frame(width: 130, height: 120)
                    .accessibilityIdentifier("paw-logo")
                
                Spacer()
                
                
                Button("Login") {
                    // TODO: login logic
                }
                .frame(width: 100)
                .buttonStyle(.bordered)
                .background(Color(red: 0x50/255, green: 0xB7/255, blue: 0xB7/255))
                .foregroundColor(.white)
                .cornerRadius(10)
                .accessibilityIdentifier("loginButton")
                
                
                
                Button("Sign Up") {
                    // TODO: sign up logic
                }
                .frame(width: 100)
                .buttonStyle(.bordered)
                .background(Color(red: 0x50/255, green: 0xB7/255, blue: 0xB7/255))
                .foregroundColor(.white)
                .cornerRadius(10)
                .accessibilityIdentifier("signUpButton")
                
                Spacer()
            }
        }
    }
}

struct WelcomePageView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePageView()
    }
}
