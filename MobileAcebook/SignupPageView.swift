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
    @State private var avatar: String = ""
    
    func submitUser() -> Void {
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/users")!)
        request.httpMethod = "POST"
        
        var user = User(email: email, username: username, password: password)
        print(user)
        
        let jsonEncoder = JSONEncoder()
        let jsonResultData = try? jsonEncoder.encode(user)
        
        print(jsonResultData)
        
        request.httpBody = jsonResultData
        
        print(request.httpBody)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        }
        task.resume()
    }
    
    var body: some View {
        VStack{
            Text("Sign-up")
            NavigationView {
                List {
                    TextField(
                        "Username",
                        text: $username
                    )
                    TextField(
                        "Email address",
                        text: $email
                    )
                    SecureInputView(
                        "Password",
                        text: $password
                    )
                    SecureInputView(
                        "Re-enter Password",
                        text: $password2
                    )
                }
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
