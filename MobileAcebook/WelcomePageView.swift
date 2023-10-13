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
       Color.blue
            .ignoresSafeArea()
        Circle()
            .scale(1.7)
            .foregroundColor(.white.opacity(0.15))
        Circle()
            .scale(1.35)
            .foregroundColor(.white)
    VStack {
     Spacer()
     Text("Welcome to Acebook!")
      .font(.largeTitle)
      .padding(.bottom, 20)
      .accessibilityIdentifier("welcomeText")
//     Spacer()
     Image("makers-logo")
      .resizable()
      .scaledToFit()
      .frame(width: 200, height: 200)
      .accessibilityIdentifier("makers-logo")
        
        
    
    NavigationLink("Log In", destination: LogInView())
        .accessibilityIdentifier("logInButton")
        .foregroundColor(.white)
        .frame(width: 250, height: 50)
        .background(Color.blue.opacity(0.80))
        .cornerRadius(10)
        
     NavigationLink("Sign Up", destination: SignUpView())
     .accessibilityIdentifier("signUpButton")
//     .foregroundColor(.white)
//     .frame(width: 300, height: 50)
//     .background(Color.blue)
//     .cornerRadius(10)

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
