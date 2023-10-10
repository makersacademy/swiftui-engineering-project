//
//  AuthenticationServiceProtocol.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

public protocol AuthenticationServiceProtocol {
    
    typealias AuthCallback = (String?, Error?) -> Void
    
    func signUp(user: User) -> Bool
    func signIn(email: String, password: String, completion: @escaping AuthCallback)
}
