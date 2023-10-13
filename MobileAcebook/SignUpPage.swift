//
// WelcomePageView.swift
// MobileAcebook
//
// Created by Josué Estévez Fernández on 30/09/2023.
//
import SwiftUI

struct PasswordToggleTextField: View { //without this the eye (toggling) is not working!
    @Binding var text: String
    var isSecure: Bool

    var body: some View {
        if isSecure {
            SecureField("Password", text: $text)
        } else {
            TextField("Password", text: $text)
        }
    }
}

struct SignUpView: View {
  @State private var authenticationService = AuthenticationService()
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var SignedUp = false
  @EnvironmentObject var token: Token
  @State private var isPasswordVisible = false // this starts the control of the visualisation of the hidden password
    
    
  var body: some View {
    NavigationView {
      VStack {
          Spacer()
                              
          Image("makers-logo")
              .resizable()
              .scaledToFit()
              .frame(width: 200, height: 200)
              .accessibilityIdentifier("makers-logo")
          
          TextField("email", text: $email).textInputAutocapitalization(.never)
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .padding()
          
          HStack {
              PasswordToggleTextField(text: $password, isSecure: !isPasswordVisible)
                  .textFieldStyle(RoundedBorderTextFieldStyle())
                  .padding()
              
              Button(action: {
                  isPasswordVisible.toggle() // Toggle the visibility of the password
              }) {
                  Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                      .padding(.trailing, 8)
              }
          }    
          
          Text("\(authenticationService.error_message)").foregroundColor(.red)          
          
          Button(action: {
              authenticationService.register(user: User(email: email, password: password)) { isSuccess in
              if isSuccess {
                  SignedUp = true
              }
//              print("4")
              self.token.content = authenticationService.userToken
            }
//            print("2")
          }) {
            Text("SignUp")
          }
          .accessibilityIdentifier("SignUpButton")
          
          NavigationLink(destination: LogInView().environmentObject(token).navigationBarBackButtonHidden(true), isActive: $SignedUp) { EmptyView() }
          Spacer()
        }
      }
    }
  }
struct SignUpView_Previews: PreviewProvider {
  static var previews: some View {
    SignUpView().environmentObject(Token())  }
}
