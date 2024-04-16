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
    
    var body: some View {
        NavigationView {
                
            VStack {
                Spacer()
                Text("Log in")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                Text("Username")                    .frame(maxWidth: 220, alignment: .topLeading)
                
                TextField("", text: $username)
                    .frame(width: 220, height: 40)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
                    .accessibilityIdentifier("loginUsername")
                Text("Password")
                    .frame(maxWidth: 220, alignment: .topLeading)
                TextField("", text: $password)
                    .frame(width: 220, height: 40)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
                    .accessibilityIdentifier("loginPassword")
                Button("Submit") {
                    guard !username.isEmpty && !password.isEmpty else { return }
                }
                .frame(width: 220, height: 40)
                .background(Color(red: 0x50/255, green: 0xB7/255, blue: 0xB7/255))
                .foregroundColor(.white)
                .cornerRadius(5)
                .padding()
                
                Spacer()
                Spacer()
            }
            
        }
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
