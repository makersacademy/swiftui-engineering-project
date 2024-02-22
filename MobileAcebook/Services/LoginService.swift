//
//  LoginService.swift
//  MobileAcebook
//
//  Created by Holly Page on 20/02/2024.
//

import Foundation

// Function to save token in Keychain
func saveTokenToKeychain(token: String) {
    // Convert the token string to Data
    guard let tokenData = token.data(using: .utf8) else {
        print("Failed to convert token to data.")
        return
    }
    
    // Define the query parameters for the Keychain item
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: "authenticationToken", // Unique identifier for the token
        kSecValueData as String: tokenData,
        kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked // Token accessible when device is unlocked
    ]
    
    // Delete any existing token
    let deleteResult = SecItemDelete(query as CFDictionary)
    guard deleteResult == errSecSuccess || deleteResult == errSecItemNotFound else {
        print("Failed to delete existing token from Keychain.")
        return
    }
    
    // Add the token to the Keychain
    let addResult = SecItemAdd(query as CFDictionary, nil)
    guard addResult == errSecSuccess else {
        print("Failed to save token to Keychain.")
        return
    }
    
    print("Token saved to Keychain.")
}

struct Token: Decodable {
    let token: String
}

// Function to retrieve token from Keychain
func retrieveTokenFromKeychain() -> Token? {
    // Define the query parameters for retrieving the Keychain item
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: "authenticationToken", // Unique identifier for the token
        kSecReturnData as String: kCFBooleanTrue!,
        kSecMatchLimit as String: kSecMatchLimitOne
    ]
    
    // Try to retrieve the token from the Keychain
    var item: CFTypeRef?
    let status = SecItemCopyMatching(query as CFDictionary, &item)
    
    guard status == errSecSuccess, let tokenData = item as? Data else {
        print("Failed to retrieve token from Keychain.")
        return nil
    }
    
    // Convert the retrieved data to a string
    let token = try? JSONDecoder().decode(Token.self, from: tokenData)
    
    return token
}
