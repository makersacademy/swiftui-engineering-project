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
        SecureField("Password", text: $user.password)
          .padding()
        TextField("Username", text: $user.username)
          .padding()
        Button("Sign Up") {
          Task {
            do {
              try await signUp()
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
  func signUp() async throws {
    let payload: [String: Any] = [
      "email": user.email,
      "password": user.password,
      "username": user.username
    ]
    let url = URL(string: "http://localhost:3000/users")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let jsonData = try JSONSerialization.data(withJSONObject: payload)
    request.httpBody = jsonData
    let (data, response) = try await URLSession.shared.data(for: request)
    guard let httpResponse = response as? HTTPURLResponse else {
      throw NSError(domain: "InvalidResponse", code: 0, userInfo: nil)
    }
    if httpResponse.statusCode == 201 {
      return
    } else {
      throw NSError(domain: "HTTPError", code: httpResponse.statusCode, userInfo: ["message": "Received status \(httpResponse.statusCode) when signing up. Expected 201"])
    }
  }
}
struct SignUpPageView_Previews: PreviewProvider {
  static var previews: some View {
    SignUpPageView()
  }
}
