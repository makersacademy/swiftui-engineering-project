//
//  NavigationTabView.swift
//  MobileAcebook
//
//  Created by Si on 20/02/2024.
//


import SwiftUI
import Foundation

struct NavigationTabView: View {
    @ObservedObject var authService = AuthenticationService()
    var body: some View {
        NavigationView {
            VStack {
                // Top bar with back and logout buttons
                HStack {
                    Spacer()
                    Button(action: {
                        authService.logout()
                    }) {
                        Text("Logout")
                            .foregroundColor(.black)
                    }
                }
                .padding()
                
                // Tab view content
                TabView {
                    PostPageView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                                .foregroundColor(.black) // Set color to black
                        }
                    CreatePostView()
                        .tabItem {
                            Label("Add Post", systemImage: "plus.bubble.fill")
                                .foregroundColor(.black)
                        }
                    ProfilePageView()
                        .tabItem {
                            Label("Profile", systemImage: "person")
                                .foregroundColor(.black)
                        }
                }
                .accentColor(.black)
            }
        }
    }
}

struct NavigationTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTabView()
    }
}

