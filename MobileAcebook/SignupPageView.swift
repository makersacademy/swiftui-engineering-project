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
            Text("Sign-up")
            NavigationView {
                List {
                    TextField(
                        "Username",
                        text: $username
                    ).autocapitalization(.none)
                    TextField(
                        "Email address",
                        text: $email
                    ).autocapitalization(.none)
                    SecureInputView(
                        "Password",
                        text: $password
                    ).textContentType(.oneTimeCode)
                    SecureInputView(
                        "Re-enter Password",
                        text: $password2
                    ).textContentType(.oneTimeCode)
                }
            }
            if password != password2 {
                Text("Passwords must match!").foregroundStyle(.red)
            }
            Button(action: submitUser) {
                Text("Submit")
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
