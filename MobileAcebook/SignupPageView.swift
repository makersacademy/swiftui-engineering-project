//
//  signupPageView.swift
//  MobileAcebook
//
//  Created by Alice Birkett on 09/10/2023.
//

import SwiftUI

struct SignupPageView: View {
    
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var password2: String = ""
    @State private var avatar: String? = nil
    
    func submitUser() -> Void {
        let signupService = SignupService(email: email, username: username, password: password, password2: password2, avatar: avatar)
        signupService.createAccount()
    }
    
    var body: some View {
        VStack{
            Image("makers-logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .accessibilityIdentifier("makers-logo")
            Text("Sign-up")
            TextField(
                "Username",
                text: $username
                )
            .padding()
            .foregroundColor(.black)
            .frame(width: 303, height: 36)
            .background(.white)
            .cornerRadius(6)
            .overlay(RoundedRectangle(cornerRadius: 6)
            .inset(by: 0.5)
            .stroke(Color(red: 0.16, green: 0.16, blue: 0.16).opacity(0.5), lineWidth: 1))
            TextField(
                "Email address",
                text: $email)
            .padding()
            .foregroundColor(.black)
            .frame(width: 303, height: 36)
            .background(.white)
            .cornerRadius(6)
            .overlay(RoundedRectangle(cornerRadius: 6)
            .inset(by: 0.5)
            .stroke(Color(red: 0.16, green: 0.16, blue: 0.16).opacity(0.5), lineWidth: 1))
            SecureInputView(
                "Password",
                text: $password
            )
            .padding()
            .foregroundColor(.black)
            .frame(width: 303, height: 36)
            .background(.white)
            .cornerRadius(6)
            .overlay(RoundedRectangle(cornerRadius: 6)
            .inset(by: 0.5)
            .stroke(Color(red: 0.16, green: 0.16, blue: 0.16).opacity(0.5), lineWidth: 1))
            SecureInputView(
                "Re-enter Password",
                text: $password2
            )
            .padding()
            .foregroundColor(.black)
            .frame(width: 303, height: 36)
            .background(.white)
            .cornerRadius(6)
            .overlay(RoundedRectangle(cornerRadius: 6)
            .inset(by: 0.5)
            .stroke(Color(red: 0.16, green: 0.16, blue: 0.16).opacity(0.5), lineWidth: 1))
            if password != password2 {
                Text("Passwords must match!").foregroundStyle(.red)
            } else if password.count < 8 {
                Text("Passwords must have a length of 8 or more").foregroundStyle(.red)
            } else if password.lowercased() == password {
                Text("Passwords must hava a capital letter").foregroundStyle(.red)
            } else {
                NavigationLink(destination: SignInView()) {
                    Text("Submit")
                    
                }.simultaneousGesture(TapGesture().onEnded {
                    submitUser()
                })
                
                    
                }
             
        
               
        }
    }
}

struct SignupPageView_Previews: PreviewProvider {
    static var previews: some View {
        SignupPageView()
    }
}

struct SecureInputView: View {
    
    @Binding private var text: String
    @State private var isSecured: Bool = true
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField(title, text: $text)
                } else {
                    TextField(title, text: $text)
                }
            }.padding(.trailing, 32)

            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(.gray)
            }
        }
    }
}
