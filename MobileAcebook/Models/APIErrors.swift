//
//  APIErrors.swift
//  MobileAcebook
//
//  Created by Amy Brown on 17/04/2024.
//

import Foundation

public enum APIError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)
    case invalidData
}
