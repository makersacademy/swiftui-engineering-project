//
//  SignUpPageView.swift
//  MobileAcebook
//
//  Created by Fara on 16/04/2024.
//

import SwiftUI

struct SignUpPageView: View {
  @State private var user = User(email: "", username: "", password: "")
  @State private var signUpError: Error? = nil
  @State private var isSignedUp = false
  var body: some View {
    NavigationView {
      VStack {
        Image("makers-logo")
          .resizable()
          .scaledToFit()
          .frame(width: 200, height: 200)
          .accessibilityIdentifier("makers-logo")
        TextField("Email", text: $user.email)
          .padding()
          .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
        SecureField("Password", text: $user.password)
          .padding()
          .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
        TextField("Username", text: $user.username)
          .padding()
          .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
        Button("Sign Up") {
          Task {
            do {
                let authService = AuthenticationService()
                try await
                authService.signUp(user:user)
                isSignedUp = true
            } catch {
              signUpError = error
            }
          }
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .font(.headline)
        .cornerRadius(8)
        if let error = signUpError {
          Text("Error: \(error.localizedDescription)")
        }
        NavigationLink(destination: WelcomePageView(), isActive: $isSignedUp) {
          EmptyView()
        }
      }
      .padding()
    }
  }

}
struct SignUpPageView_Previews: PreviewProvider {
  static var previews: some View {
    SignUpPageView()
  }
}
