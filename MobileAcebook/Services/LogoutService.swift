//
//  LogoutService.swift
//  MobileAcebook
//
//  Created by Si on 21/02/2024.
//

import Foundation

// Logout - Token deletion
func deleteTokenFromKeychain() {
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
}
