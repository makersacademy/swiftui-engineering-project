//
//  LogoutViewModel.swift
//  MobileAcebook
//
//  Created by Dan Gullis on 21/02/2024.
//

import SwiftUI
import Foundation

class LogoutViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var successMessage: String?
    @Published var isLogoutSuccessful = false
    @Published var logoutError: Error?
    
    private let authenticationService: AuthenticationServiceProtocol

    init(authenticationService: AuthenticationServiceProtocol = AuthenticationService.shared) {
        self.authenticationService = authenticationService
    }

    func signOut() {
        authenticationService.signOut { result in
            switch result {
            case .success:
                self.isLogoutSuccessful = true
                print("Successfully signed out")
            case .failure(let error):
                self.logoutError = error
                print("Failed to sign out: \(error)")
            }
        }
    }
}
