//
//  CreateCommentModel.swift
//  MobileAcebook
//
//  Created by Bogdan Stăiculescu on 18/04/2024.
//

import Foundation


public struct Comment: Encodable {
    let message: String
    let createdByUser: String
    let createdAtDate: String
    let sitsUnderPost: String
}
