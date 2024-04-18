//
//  AuthenticationServiceProtocol.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

public protocol AuthenticationServiceProtocol {
    func signUp(user: User) async throws
    func login(user: User, completion: @escaping (Result<String, Error>) -> Void)
}
