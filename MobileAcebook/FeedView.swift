//
//  SwiftUIView.swift
//  MobileAcebook
//
//  Created by Alina Ermakova on 09/10/2023.
//

import SwiftUI

struct FeedView: View {
    
    @State var postTextField: String = ""
    @State var postArray: [String] = []
    
    var body: some View {
        TextField("Write a post", text: $postTextField)
        .padding()
        .foregroundColor(.black)
        .frame(width: 303, height: 36)
        .background(.white)
        .cornerRadius(6)
        .overlay(RoundedRectangle(cornerRadius: 6)
        .inset(by: 0.5)
        .stroke(Color(red: 0.16, green: 0.16, blue: 0.16).opacity(0.5), lineWidth: 1))
        Button(action: {
            createPost()
        }, label: {
            Text("Post")
        })
    }
    
    func createPost() {
        postArray.append(postTextField)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
