//
//  WelcomePageView.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 30/09/2023.
//

import SwiftUI


struct WelcomePageView: View {
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                Text("Welcome to Acebook!")
                    .font(.largeTitle)
                    .padding(.bottom, 20)
                    .accessibilityIdentifier("welcomeText")
                
                Spacer()
                
                Image("makers-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .accessibilityIdentifier("makers-logo")
                
                Spacer()
                
                HStack{
                    Button(action: {
                        print("Floating Button Click")
                    }, label: {
                        NavigationLink(destination: SignInView()) {
                             Text("Sign In")
                            .padding(.horizontal, 15)
                            .padding(.vertical, 12)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .font(.body)
                            .frame(width: 120, height: 80)
                         }
                    })
                    
                    Button(action: {
                        print("Floating Button Click")
                    }, label: {
                        NavigationLink(destination: SignupPageView()) {
                             Text("Sign Up")
                            .padding(.horizontal, 12)
                            .padding(.vertical, 12)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .font(.body)
                            .frame(width: 120, height: 80)
                         }
                    })
                }
                
                Spacer()
            }
        }
    }
}

struct WelcomePageView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePageView()
    }
}
