//
//  LoginPageView.swift
//  MobileAcebook
//
//  Created by Holly Page on 19/02/2024.
//

import SwiftUI

struct LoginPageView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()

                Image("makers-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .accessibilityIdentifier("makers-logo")

                Text("Please enter your details")
                    .font(.caption)
                    .bold()
                   
                Spacer()
                
                VStack(alignment: .leading, spacing: 15) {
                
                    
                    TextField("", text: self.$email, prompt: Text("Email").foregroundColor(.white))
                        .padding()
                        .background(.black)
                        .cornerRadius(20.0)
                        .foregroundColor(.white)
                        
                    SecureField("", text: self.$password, prompt: Text("Password").foregroundColor(.white))
                        .padding()
                        .background(.black)
                        .cornerRadius(20.0)
                        .foregroundColor(.white)
                    
                }.padding([.leading, .trailing], 27.5)
                
                Spacer()
                
                Button("Login") {
                    // TODO: log in logic
                }.font(.headline)
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.black)
                .cornerRadius(15.0)
                .accessibilityIdentifier("loginButton")
                
                Spacer()
                Divider()
            
                VStack{
                    Text("Don't have an account?").bold()
                    Button("Click here"){
                        //Redirects to sign up
                    }.foregroundColor(.white)
                        .frame(width: 100, height: 30)
                        .background(Color.black)
                        .cornerRadius(15.0)
                        .accessibilityIdentifier("clickHereButton")
                }
                    
            }
        }
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
