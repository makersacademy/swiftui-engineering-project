//
//  AuthenticationService.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

import Foundation

class AuthenticationService: AuthenticationServiceProtocol, ObservableObject {
    func signUp(user: User) -> Bool {
        // Logic to call the backend API for signing up
        return true // placeholder
    }
    
    func logout() {
        // Remove token from UserDefaults
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.setValue(false, forKey: "isAuthenticated")
        
        // Delete the token from Keychain
        deleteTokenFromKeychain()
        
        // Notify observers about the authentication state change
        DispatchQueue.main.async {
            self.objectWillChange.send()
            
            // Navigate to the welcome page
            NotificationCenter.default.post(name: .logoutNotification, object: nil)
        }
    }

}
