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
        GridItem(.flexible(minimum: 5)),
        GridItem(.flexible(minimum: 175))
    ]
    
    @ObservedObject var postsModel = PostsView()
    @ObservedObject var loggedinUserModel = LoggedInUser()
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()

                Text("My Profile")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(.black)
                    .cornerRadius(30.0)
                    .accessibilityIdentifier("titleText")

                HStack{
                    Image("makers-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75, height: 100)
                        .accessibilityIdentifier("profile-picturem")
                    LazyVGrid(columns: layout, alignment: .leading, content: {
                        Text("Username:").font(.headline)
                        Text(loggedinUserModel.user?.username ?? "")
                        Text("")
                        Text("")
                        Text("Email: ").font(.headline)
                        Text(loggedinUserModel.user?.email ?? "")
                    }).onAppear{
                        loggedinUserModel.fetchUser()
                    }
        
                }
                Spacer()
                Text("Posts")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 100, height: 35)
                    .background(.black)
                    .cornerRadius(30.0)
                    .accessibilityIdentifier("titleText")
                List{
                    ForEach(postsModel.posts) {post in
                        if post.createdBy == loggedinUserModel.user?._id {
                            ScrollView {
                                VStack(alignment: .leading) {
                                    Text(post.message)
                                    Spacer()
                                    Text(convertDateFormat(inputDate: post.createdAt)).font(.footnote)
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
