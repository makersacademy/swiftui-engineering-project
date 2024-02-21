//
//  LoginViewModel.swift
//  MobileAcebook
//
//  Created by Holly Page on 19/02/2024.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""
    
    func login(){
        LoginAction(
            parameters: LoginRequest(
                username: username,
                password: password
            )
        ).call {
            _ in
        }
    }
}
