//
//  LogInViewModel.swift
//  MobileAcebook
//
//  Created by Dan Gullis on 20/02/2024.
//

import Foundation

//struct LoginResponse: Codable {
//    var token: String
//    var message: String
//}
//
//struct LoginError: Error {
//    var localizedDescription: String
//}

class LoginViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var successMessage: String?
    @Published var isLoggingIn: Bool = false

    private let authenticationService: AuthenticationServiceProtocol
    
    init(authenticationService: AuthenticationServiceProtocol = AuthenticationService.shared) {
            self.authenticationService = authenticationService
        }
    func logIn(email: String, password: String) {
        isLoggingIn = true
        authenticationService.logIn(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.errorMessage = nil
                    self.successMessage = "Login successful"
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
                self.isLoggingIn = false
            }
        }
    }
}
    

