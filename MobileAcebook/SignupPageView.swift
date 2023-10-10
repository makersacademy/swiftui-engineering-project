//
//  SignupPageView.swift
//  MobileAcebook
//
//  Created by Emily Cowan on 09/10/2023.
//

import SwiftUI

struct SignupPageView: View {
    @State private var readyToNavigate : Bool = false
    
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
                    
                    Button {
                        readyToNavigate = true
                    } label: {
                        Text("Sign Up")
                            .foregroundColor(Color("Gunmetal"))
                    }
                }
                .navigationDestination(isPresented: $readyToNavigate) {
                    WelcomePageView().navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}


struct SignupPageView_Previews: PreviewProvider {
    static var previews: some View {
        SignupPageView()
    }
}
