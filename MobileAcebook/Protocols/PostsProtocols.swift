//
//  PostsProtocols.swift
//  MobileAcebook
//
//  Created by Alannah Lawlor on 16/04/2024.
//

import Foundation

//public protocol AuthenticationServiceProtocol {
//    func signUp(user: User) -> Bool

public protocol PostService {
    func createPost(token: String, message: String, completion: @escaping (Result<String, Error>) -> Void)
    func getPosts(JWTtoken: String, completion: @escaping (Result<PostAPIResponse, PostAPIError>) -> Void)
}
