//
//  FeedView.swift
//  MobileAcebook
//
//  Created by Gabriela Ehrenbrink on 20/02/2024.
//
import Foundation
import SwiftUI

struct FeedView: View {
//    var user: User?
    @State private var isLoggedOut = false
    @State private var isPersonClicked = false
    var body: some View {
        
        NavigationView {
            List {
                Text("Hello, SwiftUI!")
                Text("Hello, SwiftUI!")
                Text("Hello, SwiftUI!")
                Text("Hello, SwiftUI!")
                Text("Hello, SwiftUI!")
                Text("Hello, SwiftUI!")
            }
            .navigationTitle("Feed")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProfileView(), isActive: $isPersonClicked) {
                        Button(action: {
                            // Action to perform for navigating to ProfileView
                            isPersonClicked = true
                        }) {
                            Image(systemName: isPersonClicked ? "person.fill" : "person")
                                .foregroundColor(.black)
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: LoginPage(authenticationService: AuthenticationService()), isActive: $isLoggedOut) {
                        Button(action: {
                            // Action to perform for logout
                            isLoggedOut = true
                        }) {
                            Image(systemName: isLoggedOut ? "rectangle.portrait.and.arrow.right.fill" : "rectangle.portrait.and.arrow.right")
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct FeedViewPage_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
