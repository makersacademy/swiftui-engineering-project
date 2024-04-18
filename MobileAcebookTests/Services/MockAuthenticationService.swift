//
//  MockAuthenticationService.swift
//  MobileAcebookTests
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

@testable import MobileAcebook

class MockAuthenticationService: AuthenticationServiceProtocol {
    func signUp(user: User) async throws {}
    func login(user: User, completion: @escaping (Result<String, Error>) -> Void) {}
}
