//
//  AuthenticationServiceProtocol.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

public protocol AuthenticationServiceProtocol {
    func signIn(user: LoginUser, completion: @escaping (Result<Token, Error>) -> Void)
    func signUp( user: User) -> Bool
    func getUserInfo(JWTtoken: String, completion: @escaping (Result<GetUserResponse, APIError>) -> Void)
}
