//
//  SignUpView.swift
//  MobileAcebook
//
//  Created by philip hanlon on 15/04/2024.
//
 
import SwiftUI

struct SignUpView: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var imgurl = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
   
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                //            SecureField("Confirm Password", text: $confirmPassword)
                //                .textFieldStyle(RoundedBorderTextFieldStyle())
                //                .padding()
                
                TextField("Profile Pic URL", text:
                            $imgurl)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                Button("Sign Up") {
                    let newSignUp = NewUser(email: email, password: password, username: username, imgurl: imgurl)
                    let authenticate = AuthenticationService()
                    let signUpAction = authenticate.signUp(user: newSignUp)
                    showAlert = true
                    alertMessage = "Sign up successfull"
                    
                    
                    
                    //                if password == confirmPassword {
                    //
                    //                    showAlert = true
                    //                    alertMessage = "Sign up successful!"
                    //                } else {
                    //                    showAlert = true
                    //                    alertMessage = "Passwords do not match."
                    //                }
                }
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Sign Up"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
            .padding()
        }
    }
}

#Preview {
    SignUpView()
}
