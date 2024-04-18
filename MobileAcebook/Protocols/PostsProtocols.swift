//
//  PostsProtocols.swift
//  MobileAcebook
//
//  Created by Alannah Lawlor on 16/04/2024.
//

import Foundation

public protocol PostService {
    func createPost(JWTtoken: String, message: String, completion: @escaping (Result<String, Error>) -> Void)
    func getPosts(JWTtoken: String, completion: @escaping (Result<PostAPIResponse, APIError>) -> Void)
    func likePost(JWTtoken: String, postId: String, completion: @escaping (Result<LikeAPIResponse, Error>) -> Void)
}
