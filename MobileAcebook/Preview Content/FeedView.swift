//
//  FeedView.swift
//  MobileAcebook
//
//  Created by Gabriela Ehrenbrink on 20/02/2024.
//
import Foundation
import SwiftUI

struct FeedView: View {
    let user: User // Assuming you have a User model or structure

    var body: some View {
        VStack {
            Text("Welcome, \(user.username)")
                .font(.title)
                .padding()
            
            Text("Email: \(user.email)")
                .padding()
        }
    }
}
