//
//  WelcomePageView.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 30/09/2023.
//

import SwiftUI

struct WelcomePageView: View {
    @State private var readyToNavigateSignUp : Bool = false
    @State private var readyToNavigateLogIn : Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Magnolia")
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack {
                    Spacer()
                    
                    Text("Welcome to Magebook!")
                        .font(.largeTitle)
                        .foregroundColor(Color("Gunmetal"))
                        .padding(.bottom, 20)
                        .accessibilityIdentifier("welcomeText")
                    
                    Spacer()
                    
                    Image("makers-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .accessibilityIdentifier("makers-logo")
                    
                    Spacer()
                    
                    
                    HStack {
                        Button {
                            readyToNavigateSignUp = true
                        } label: {
                            Text("Sign Up")
                                .foregroundColor(Color("Gunmetal"))
                        }.tint(Color("Magenta"))
                        Button {
                            readyToNavigateLogIn = true
                        } label: {
                            Text("Log In")
                                .foregroundColor(Color("Gunmetal"))
                        }.tint(Color("Magenta"))
                    }
                .navigationDestination(isPresented: $readyToNavigateSignUp) {
                    SignupPageView().navigationBarBackButtonHidden(true)
                }
                
                }.navigationDestination(isPresented: $readyToNavigateLogIn) {
                    loginView().navigationBarBackButtonHidden(true)
            }
            }
        }
    }
}

struct WelcomePageView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePageView()
    }
}

