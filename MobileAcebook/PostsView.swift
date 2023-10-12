//
//  PostsView.swift
//  MobileAcebook
//
//  Created by Jenny Wark on 11/10/2023.
//

import SwiftUI

struct PostsView: View {
    @EnvironmentObject var token: Token
    @State private var authenticationService = AuthenticationService()
    @State private var post_content: String = ""
    @State private var posts_array: Array<Post> = []
    @State private var loggedIn = false
    
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
                    authenticationService.createPost(post: Post(id: "usbenwokrbm", message: post_content), token: token)
                }) {
                    Text("Create Post")
                }
                .accessibilityIdentifier("CreatePostButton")
                
                Spacer()
                
                Button(action: {
                    authenticationService.allPosts(token: token) { isSuccess in
                        if isSuccess {
                            loggedIn = true
                        }
//                            print("4")
                        self.token.content = authenticationService.userToken
                        posts_array = authenticationService.posts_array
                    }
//                        print("2")
                }) {
                    Text("Show posts")
                }
                .accessibilityIdentifier("PostsButton")
                
                List(posts_array) { post in
                                Text(post.message)
                            }
                            .navigationBarTitle("Posts")
               
                
                Spacer()
                
            }
        }
  }
}

struct PostsView_Previews: PreviewProvider {
  static var previews: some View {
      PostsView().environmentObject(Token())
  }
}
