//
//  WelcomePageView.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 30/09/2023.
//

import SwiftUI

struct WelcomePageView: View {
    @State private var email: String = ""
    @State private var password: String = ""
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
                
                
                Form {
                    TextField("email", text: $email)
                    TextField("password", text: $password)
                }
                
                Spacer()
                
                Button("Sign Up") {
                    var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/users")!)
                    request.httpMethod = "POST"
                    let json: [String: Any] = ["email": email, "password": password]
                    let jsonData = try? JSONSerialization.data(withJSONObject: json)
                    request.httpBody = jsonData
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                        if let error = error {
                            print("Error: \(error.localizedDescription)")}
                    }
                    task.resume()
                }
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
