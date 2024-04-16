//
//  SignUpPageView.swift
//  MobileAcebook
//
//  Created by Venera Zhargakova on 16/04/2024.
//

import Foundation

import SwiftUI
struct SignUpPageView: View {
    @State private var email = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    //errors:
    @State private var emailError = ""
    //let authService: AuthenticationServiceProtocol
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("Sign Up")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                VStack(spacing:0) {
                    Text("Email Address")
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding()
                    TextField("", text: $email)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: 350)
                    //sure
                        .border(Color.gray)
                    Text("Full Name")
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding()
                    TextField("Enter your full name", text: $fullName)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .border(Color.gray)
                    Text("Password")
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding()
                    TextField("Enter a password", text: $password)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .border(Color.gray)
                    Text("Confirm Password")
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding()
                    TextField("Enter a password", text: $confirmPassword)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .border(Color.gray)
                    Text("Image upload placeholder")
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding()
                    //placeholder for image upload - format to be defined.
                    VStack{
                        Button("Sign Up"){
                            //add logic here
                        }
                        .frame(width: 250)
                        .padding()
                        .background(Color(red: 0x50/255, green: 0xB7/255, blue: 0xB7/255))
                        .foregroundColor(.white)
                        .cornerRadius(50)
                    }
                    .padding(.top, 40)
                    Spacer()
                    HStack(spacing:3){
                        Text("Already have an account?")
                        Text("Login here")
                            .fontWeight(.bold)
                        //add navigation to login
                    }
                    .padding()
                }
            }
        }
    }
}
#Preview {
    SignUpPageView()
}







