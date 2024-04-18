//
//  CommentsProtocols.swift
//  MobileAcebook
//
//  Created by Amy Brown on 17/04/2024.
//

import Foundation

public protocol CommentService {
    func createComment(postId:String, token: String, message: String, completion: @escaping (Result<String, Error>) -> Void)
    func getComments(postId: String, JWTtoken: String, completion: @escaping (Result<CommentAPIResponse, APIError>) -> Void)
}
