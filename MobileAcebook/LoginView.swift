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
    @State private var readyToNavigate : Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Magnolia")
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack{
                    VStack{
                        Text("Login")
                            .bold().font(.largeTitle)
                            .padding(.top, 50)
                            .foregroundColor(Color("Gunmetal"))
                    }
                    Spacer()
                    VStack{
                        Image("MageBook-logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 200)
                            .accessibilityIdentifier("MageBook-logo")
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
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
                                // TODO: sign up logic
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.primary)
                            .cornerRadius(20)
                            .frame(width: 100, height: 50)
                            .padding(.trailing, 90)
                            
                            
                        }
                    }
                    .frame(width: 500)
                    Spacer()
                    VStack {
                        Button {
                            readyToNavigate = true
                        } label: {
                            Text("Sign up here")
                                .foregroundColor(Color("Gunmetal"))
                        }
//                        .padding(.bottom, 50)
                        
                    }
                }
            }.navigationDestination(isPresented: $readyToNavigate) {
                SignupPageView().navigationBarBackButtonHidden(true)
            }
        }
    }

}
#Preview {
    loginView()
}
