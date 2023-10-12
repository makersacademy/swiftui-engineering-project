//
// WelcomePageView.swift
// MobileAcebook
//
// Created by Josué Estévez Fernández on 30/09/2023.
//
import SwiftUI
struct WelcomePageView: View {
 var body: some View {
  NavigationView {
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
     NavigationLink("Sign Up", destination: SignUpView())
     .accessibilityIdentifier("signUpButton")
      NavigationLink("Log In", destination: LogInView())
      .accessibilityIdentifier("logInButton")
     Spacer()
    }
   }
  }
 }
}
struct WelcomePageView_Previews: PreviewProvider {
 static var previews: some View {
  WelcomePageView() }
}
