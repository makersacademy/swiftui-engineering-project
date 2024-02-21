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
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: "authenticationToken"
            ]
            
            let deleteResult = SecItemDelete(query as CFDictionary)
            if deleteResult == errSecSuccess {
                print("Token successfully deleted from Keychain.")
            } else {
                print("Failed to delete token from Keychain.")
            }
            
            // Notify observers about the authentication state change
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }

}
