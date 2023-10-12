//
//  SignupPageView.swift
//  MobileAcebook
//
//  Created by Emily Cowan on 09/10/2023.
//

import SwiftUI

struct SignupPageView: View {
    @State private var readyToNavigate : Bool = false
    @State private var UserEmail: String = ""
    @State private var UserPassword: String = ""
    @State private var UserUsername: String = ""
    @State private var UserPicture: String = ""
    @State private var ShowAlert: Bool = false
    @State private var AlertMessage: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Magnolia")
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack {
                    Text("Create Account")
                        .font(.largeTitle)
                        .foregroundColor(Color("Gunmetal"))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    VStack{
                        Image("MageBook-logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .accessibilityIdentifier("MageBook-logo")
                    }
                    
                    VStack {
                        TextField("Enter your email address", text: $UserEmail)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 350)
                        SecureField("Enter your password", text: $UserPassword)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 350)
                        TextField("Enter your username", text: $UserUsername)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 350)
                        TextField("Profile Picture", text: $UserPicture)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 350)
                        
                        
                        HStack{
                            Spacer()
                            Button("Sign up") {
                                readyToNavigate = true
                                if isValidEmailAddr(strToValidate: UserEmail) {
                                    signUp(username: UserUsername, email: UserEmail, password: UserPassword, avatar: UserPicture) {
                                        result in switch result {
                                        case .success:
                                            print("Successful Signup")
                                        case .failure(let error):
                                            print("Signup failed: \(error.localizedDescription)")
                                        }
                                    }
                                } else {
                                    AlertMessage = "Please enter valid email address"
                                    ShowAlert = true
                                    print("Please enter valid email address")
                                }
                            }
                            .alert(isPresented: $ShowAlert) {
                                Alert(title: Text("Signup Status"), message: Text(AlertMessage), dismissButton: .default(Text("Ok")))
                            }
                        }
                        
                        .buttonStyle(.borderedProminent)
                        .cornerRadius(20)
                        .frame(width: 150, height: 50)
                        .padding(.trailing, 90)
                        .tint(Color("Olivine"))
                    }
                    
                    .frame(width: 500)
                    
                    Spacer()
                    HStack{
                        Text("Already have an account?")
                        Button {
                            readyToNavigate = true
                        } label: {
                            Text("Click here to login")
                                .foregroundColor(Color("Magenta"))
                        }
                    }
                }
            }
            }.navigationDestination(isPresented: $readyToNavigate) {
                    loginView().navigationBarBackButtonHidden(true)
                }
            }
        }



struct SignupPageView_Previews: PreviewProvider {
    static var previews: some View {
        SignupPageView()
    }
}
