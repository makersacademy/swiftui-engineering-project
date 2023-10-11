//
//  SwiftUIView.swift
//  MobileAcebook
//
//  Created by Alina Ermakova on 09/10/2023.
//

import SwiftUI

struct FeedView: View {
    private var service = FeedService()
    @State var posts = [Post]()
    var body: some View {
        List(posts, id: \._id) { post in
            Text(post.message)
        }
        .onAppear {
            
            guard var token = UserDefaults.standard.string(forKey: "token") else {
                return
            }
                
            service.getAllPosts(token: token) { (posts, err) in
                guard var posts = posts else {
                    // handle error
                    return
                }
                self.posts = posts.posts
            }
        }
    }
}

//struct FeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedView()
//    }
//}
