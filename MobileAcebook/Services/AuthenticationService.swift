//
//  AuthenticationService.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

import Foundation

class AuthenticationService: AuthenticationServiceProtocol {
    func signUp(user: User) -> Bool {
        // Logic to call the backend API for signing up
        return true // placeholder
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.setValue(false, forKey: "isLoggedIn") // may need to change this key
    }
}
