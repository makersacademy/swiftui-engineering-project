//
//  NavigationTabView.swift
//  MobileAcebook
//
//  Created by Si on 20/02/2024.
//


import SwiftUI


struct NavigationTabView: View {
    var body: some View {
        TabView {
            HomePageView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            Text("Search")
                .tabItem {

                    Label("Search", systemImage: "magnifyingglass")
                }
            Text("Notification")
                .tabItem {

                    Label("Notification", systemImage: "bell")
                }
            Text("Profile")
                .tabItem {

                    Label("Profile", systemImage: "person")
                }
        }
    }
}

struct NavigationTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTabView()
    }
}

struct HomePageView: View {
    var body: some View {
        WelcomePageView()
    }
}
