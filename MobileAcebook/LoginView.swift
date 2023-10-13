//
//  LoginView.swift
//  MobileAcebook
//
//  Created by Dan Gibson on 10/10/2023.
//

import SwiftUI

struct loginView: View {
    @State private var UserEmail: String = ""
    @State private var UserPassword: String = ""
    @State private var signupReadyToNavigate : Bool = false
    @State private var postsReadyToNavigate : Bool = false
    @State private var ShowAlert: Bool = false
    @State private var AlertMessage: String = ""
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Magnolia")
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    VStack{
                        Text("Login")
                            .bold().font(.system(size: 46, weight: .semibold, design: .rounded))
                            .padding(.top, 50)
                            .foregroundColor(Color("Gunmetal"))
                    }
                    Spacer()
                    VStack{
                        Image("mage-hat-80s")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 200)
                            .accessibilityIdentifier("MageBook-logo")
                    }
                    Spacer()
                    VStack{
                        Text("Welcome back!")
                            .bold()
                            .font(.title3)
                            .foregroundColor(Color("Gunmetal"))
                        VStack {
                            TextField("Enter your email address", text: $UserEmail)
                            
                                .padding(.bottom, 0)
                                .padding(.top)
                                .padding(.horizontal)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 280, height: 90)
                                .textInputAutocapitalization(.never)
                            SecureField("Enter your password", text: $UserPassword)
                                .padding(.bottom)
                                .padding()
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 280, height: 90)
                            
                            
                        }.background(Color("Magenta"))
                            .cornerRadius(20)
                        HStack{
                            Spacer()
                            Button("Login") {
                                // do the post request here to tokens, wait till its done and then navigate to the posts page after pressing login button
                                loginAsync(email: UserEmail, password: UserPassword){
                                    result in switch result {
                                    case .success:
                                        print("Successful login")
                                        postsReadyToNavigate = true
                                    case .failure(let error):
                                        print("Login failed: \(error.localizedDescription)")
                                        if let nsError = error as? NSError, nsError.code == 401 {
                                            AlertMessage = "🧙‍♀️ You shall not pass! Email address not found!"
                                            ShowAlert = true
                                        }
                                        else if let nsError = error as? NSError, nsError.code == 402 {
                                            AlertMessage = "🧙‍♀️ You shall not pass! Your password is incorrect!"
                                            ShowAlert = true
                                        }
                                        else{
                                            AlertMessage = "Sign in failed: \(error.localizedDescription)"
                                            ShowAlert = true
                                            
                                        }
                                    }
                                    
                                }
                                
                            }
                            .buttonStyle(.borderedProminent)
                            //.tint(.primary)
                            .tint(Color("Olivine"))
                            .cornerRadius(20)
                            .frame(width: 100, height: 50)
                            .padding(.trailing, 90)
                            
                            
                        }
                        .alert(isPresented: $ShowAlert) {
                            Alert(title: Text("Signup Status"), message: Text(AlertMessage), dismissButton: .default(Text("OK")))
                        }
                        .frame(width: 500)
                        Spacer()
                        VStack {
                            Button {
                                signupReadyToNavigate = true
                            } label: {
                                Text("Sign up here")
                                    .foregroundColor(Color("Gunmetal"))
                            }
                            
                        }

                    }
                }.navigationDestination(isPresented: $signupReadyToNavigate) {
                    SignupPageView().navigationBarBackButtonHidden(true)
                }.navigationDestination(isPresented: $postsReadyToNavigate) {
                    PostsPageView()
                }
            }
        }
        
    }
    struct LoginPageView_Previews: PreviewProvider {
        static var previews: some View {
            loginView()
        }
    }
}
