//
//  PostsView.swift
//  MobileAcebook
//
//  Created by Jenny Wark on 11/10/2023.
//

import SwiftUI

struct PostsView: View {
    @State private var authenticationService = AuthenticationService()
    @State private var post_content: String = ""
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("Posts")
                    .font(.largeTitle)
                    .padding(.bottom, 20)
                    .accessibilityIdentifier("welcomeText")
                
                Spacer()
                
                Image("makers-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .accessibilityIdentifier("makers-logo")
                
                Spacer()
                
                TextField("Write a post", text: $post_content)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    authenticationService.createPost(post: Post(message: post_content))
                }) {
                    Text("Create Post")
                }
                .accessibilityIdentifier("CreatePostButton")
                
                Spacer()
                
//                let Posts = authenticationService.allPosts
                
                Spacer()
                
            }
        }
  }
}

struct PostsView_Previews: PreviewProvider {
  static var previews: some View {
    PostsView()
  }
}
