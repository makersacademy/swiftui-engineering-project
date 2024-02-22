//
//  MyProfilePageView.swift
//  MobileAcebook
//
//  Created by Amy McCann on 19/02/2024.
//

import Foundation
import SwiftUI

struct MyProfilePageView: View {
    let layout = [
        GridItem(.flexible(minimum: 75)),
        GridItem(.flexible(minimum: 150))
    ]
    
    @ObservedObject var postsModel = PostsView()
    @ObservedObject var loggedinUserModel = LoggedInUser()
 
  
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                Text("My Profile")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 20)
                    .accessibilityIdentifier("titleText")
                
                if let avatarImage = UIImage(named: "default_avatar.png") {
                    Image(uiImage: avatarImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .accessibilityIdentifier("profile-picture")
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .foregroundColor(.gray)
                    }
                
                
                    
                    LazyVGrid(columns: layout, alignment: .center, content: {
                        Text("Username:")
                        Text(loggedinUserModel.user?.username ?? "")
                        Text("")
                        Text("")
                        Text("Email: ")
                        Text(loggedinUserModel.user?.email ?? "")
                    }).onAppear{
                        loggedinUserModel.fetchUser()
                    }
                
                
                Spacer()
                Text("Posts").font(.title)
                List{
                    ForEach(postsModel.posts) {post in
                        if post.createdBy == loggedinUserModel.user?._id {
                            ScrollView {
                                VStack(alignment: .leading) {
                                    Text(post.message)
                                }
                            }
                        }
                        
                    }
                }
                .onAppear {
                    postsModel.fetchPosts()
                }
            }
        }
    }
}
    

struct MyProfilePageView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfilePageView()
    }
}
