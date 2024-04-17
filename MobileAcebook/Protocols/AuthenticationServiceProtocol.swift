//
//  AuthenticationServiceProtocol.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

public protocol AuthenticationServiceProtocol {
    func signIn(user: User, completion: @escaping (Result<Token, Error>) -> Void)
    func signUp( user: NewUser) -> Bool
    
}
