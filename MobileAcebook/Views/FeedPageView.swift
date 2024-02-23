//
//  FeedPageView.swift
//  MobileAcebook
//
//  Created by Alan Gardiner on 20/02/2024.
//

import SwiftUI

struct FeedPageView: View {
//    @ObservedObject var viewModel = PostModel()
//    let mockPosts = MockDataService.getMockPosts()
    @ObservedObject var Posts = PostsViewModel()
    @EnvironmentObject var authenticationManager: AuthenticationManager
    
    let token = "Needs a token"
  
    var body: some View {
        
        VStack {
            Section {
                            Text("Acebook")
                                .font(.title)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(25)
                                .padding([.bottom], -40)
                                .foregroundColor(Color.white)
                                .background(Color(hex: "3468C0"))
                            
                            CreatePostView(token: token)
                                .padding(25)
                        }
                        .background(Color(hex: "3468C0"))
                            
        VStack{
         Spacer()//All the posts in DB
            //Gets back JSON object that has "posts" : [array of posts objects]
            if Posts.postsList.isEmpty {
                Text("No posts")
            }else {
                List(Posts.postsList) {post in
                    PostView(post: post, postViewModel: Posts, token: token)
                }
                //                    .listStyle(PlainListStyle())
                .onAppear()
            }
            
        }
        .background(Color.white)
        .frame(maxWidth: .infinity)

    }
        .background(Color(hex: "3468C0"))

        .onAppear{
            _ = Posts.fetchPosts()
        }
    }
}

#Preview {
    FeedPageView()
}
