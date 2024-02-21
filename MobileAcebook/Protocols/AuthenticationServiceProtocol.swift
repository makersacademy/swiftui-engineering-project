//
//  AuthenticationServiceProtocol.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//



public protocol AuthenticationServiceProtocol {
    func signUp(user: User) -> Bool
    func logIn(email: String, password: String, completion: @escaping(Result<Void, LoginError>) -> Void)
    func signOut(completion: @escaping (Result<Void, Error>) -> Void)
    
}
