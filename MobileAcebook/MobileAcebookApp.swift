//
//  MobileAcebookApp.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 30/09/2023.
//

import SwiftUI

@main
struct MobileAcebookApp: App {
    @StateObject var authService = AuthenticationService.shared
    var body: some Scene {
        WindowGroup {
            WelcomePageView()
                .environmentObject(authService)
        }
    }
}
