//
// SignupPageView.swift
// MobileAcebook
//
// Created by Joshua Bhogal on 19/02/2024.
//

import SwiftUI

struct SignupPageView: View {
  @State private var username: String = ""
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var confPassword: String = ""

  @State private var navigateToFeedPage: Bool = false

  var body: some View {
    NavigationView {
      VStack{

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

        Form {
          Section(header: Text("Sign Up")
            .font(.title2)
            .multilineTextAlignment(.center)) {
              TextField("Username", text:$username)
              TextField("Email", text:$email)
              SecureField("Password", text:$password)
              SecureField("Confirm Password", text:$confPassword)
            }

          Section {

            Button("Sign Up") {
              let userInfo = User(username: username, email: email, password: password, confPassword: confPassword)
              if AuthenticationService().signUp(user: userInfo) {
                // generate token
                navigateToFeedPage = true
              } else{
                navigateToFeedPage = false
              }
            }.background(NavigationLink(destination: HomePageView(), isActive: $navigateToFeedPage){ EmptyView() })
          }
        }
        Spacer()
      }
    }
  }
}

#Preview {
  SignupPageView()
}
