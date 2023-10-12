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
    private var service = FeedService()
    @State var posts = [Post]()
    
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
            createNewPost()
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
            
        }, label: {
            Text("Post")
        })
        
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
    
    func createNewPost() {
        guard var token = UserDefaults.standard.string(forKey: "token") else {
            return
        }
        let post = CreatePost(image: "", message: postTextField)
        post.newPost(token: token)
    }
}

//struct FeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedView()
//    }
//}
