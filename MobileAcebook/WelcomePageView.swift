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
                    
                    Text("Welcome to")
                        .font(.system(size: 46, weight: .semibold, design: .rounded))
                        .italic()
                        .foregroundColor(Color("Gunmetal"))
                        .padding(.bottom, 10)
                        .accessibilityIdentifier("welcomeText")
                    Text("Magebook!")
                        .bold().font(.system(size: 46, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("Gunmetal"))
                        .padding(.bottom, 20)
                        .accessibilityIdentifier("welcomeText")
                    
                    Spacer()
                    
                    Image("mage-hat-80s")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding(.bottom, 40)
                        .accessibilityIdentifier("MageBook-logo")
                    
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

