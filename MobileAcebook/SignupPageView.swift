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
                        Image("mage-hat-80s")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .accessibilityIdentifier("MageBook-logo")
                    }
                    Spacer()
                    
                    VStack {
                        VStack{
                            TextField("🔮 Enter your email address", text: $UserEmail)
                                .padding() 
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 350)
                                .textInputAutocapitalization(.never)
                            SecureField("🧹 Enter your password", text: $UserPassword)
                                .padding()
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 350)
                                .textInputAutocapitalization(.never)
                            TextField("✨ Enter your username", text: $UserUsername)
                                .padding()
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 350)
                                .textInputAutocapitalization(.never)
                            TextField("🧙‍♂️ Profile Picture", text: $UserPicture)
                                .padding()
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 350)
                        }.background(Color("Magenta"))
                            .cornerRadius(20)
                        
                            
                        
                        HStack{
                            Spacer()
                            Button("Sign up") {
                                readyToNavigate = true
                                if !isValidEmailAddr(strToValidate: UserEmail) {
                                    AlertMessage = "🧙‍♀️ You shall not pass! Please enter a valid email address"
                                    ShowAlert = true
                                }
                                else if !isPasswordValid(password: UserPassword) {
                                    AlertMessage = "🧙‍♀️ You shall not pass! Password must contain at least one uppercase letter, one lowercase letter, one special character, one number and be at least 8 characters long"
                                    ShowAlert = true
                                }
                                else {
                                    signUp(username: UserUsername, email: UserEmail, password: UserPassword, avatar: UserPicture) {
                                        result in switch result {
                                        case .success:
                                            print("Successful Signup")
                                        case .failure(let error):
                                            if let nsError = error as? NSError, nsError.code == 409 {
                                                AlertMessage = "🧙‍♀️ You shall not pass! Email already exists"
                                                ShowAlert = true
                                            } else {
                                                AlertMessage = "Signup failed: \(error.localizedDescription)"
                                                ShowAlert = true
                                            }
                                        }
                                    }
                                }
                            }
                
                            .alert(isPresented: $ShowAlert) {
                                Alert(title: Text("Signup Status"), message: Text(AlertMessage), dismissButton: .default(Text("OK")))
                            }
                        }
                            
                        
                        .buttonStyle(.borderedProminent)
                        .cornerRadius(20)
                        .frame(width: 435, height: 50)
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
