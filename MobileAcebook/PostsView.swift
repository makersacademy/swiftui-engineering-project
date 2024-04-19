////
////  PostsView.swift
////  MobileAcebook
////
////  Created by Alannah Lawlor on 16/04/2024.
////
//
import SwiftUI

struct PostView: View {

    @Binding var token: String 
    @Binding var loggedIn: Bool

    @State private var message: String = ""
    @State private var postsList = [Post]()
   private let postService: PostService = APIService()
    @State private var likedPosts = Set<String>()
    
    var body: some View {
        NavigationView{
            List
            {
                Section(header: Text("Add new post")){
                    VStack {
                        TextField("Add your message here", text: $message)
                        Button("Post") {
                            guard !message.isEmpty else{
                                return
                            }
                            postService.createPost(JWTtoken: token, message: message) { result in
                                switch result {
                                case .success(let newToken):
                                    // Use the new token returned by the API
                                    //self.token = newToken
                                    print("New Post Created - token updated to: \(newToken)")
                                    postService.getPosts(JWTtoken: token, completion: handleGetPostsResult)
                                case .failure(let error):
                                    // Handle error
                                    print("Error posting: \(error)")
                                }
                                message = ""
                            }
                        }
                        .accessibilityIdentifier("PostButton")
                    }
                }
                Section(header: Text("Posts List")){
                    ForEach(postsList, id: \._id) { post in
                        NavigationLink(destination: CommentsView(post: post, token: $token ))
                        {
                            VStack {
                                Text( "\(post.message)").font(.headline)
                                Spacer(minLength: 1)
                                HStack{
                                    Text("\(post.createdBy["username"] ?? "")") .font(.subheadline)
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Text( "\(dateConverter(date: post.createdAt))") .font(.subheadline)
                                    .foregroundColor(.gray)}
                                
                            }
                            
                        }
                        
                        Text("Likes: \(post.likes?.count ?? 0)")
                        Button(action: {
                            postService.likePost(JWTtoken: token, postId: post._id) { result in
                                switch result {
                                case .success(let response):
                                    print("liked the post, \(post._id)")
                                    // Toggle the liked state of the post
                                    if likedPosts.contains(post._id) {
                                        likedPosts.remove(post._id)
                                    } else {
                                        likedPosts.insert(post._id)
                                    }
                                case .failure(let error):
                                    // Handle failure
                                    print("something didn't vibe")
                                }
                            }
                        }) {
                            if likedPosts.contains(post._id) {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                            } else {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.black)
                            }
                        }
                        
                    }
                    
                    .padding()
                }
            }.onAppear {postService.getPosts(JWTtoken: token, completion: handleGetPostsResult)}
                .navigationTitle("Posts")
                .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button(action: {
                                        // Clear the token
                                        token = ""
                                        // Navigate to the login view
                                        loggedIn = false
                                        NavigationLink(destination: LoginView(), isActive: $loggedIn) {
                                            EmptyView()
                                        }
                                    }) {
                                        Image(systemName: "rectangle.portrait.and.arrow.right")
                                    }
                                    
                    }}}
    }
    
    func handleGetPostsResult(result: Result<PostAPIResponse, APIError>) {
        switch result {
        case .success(let apiResponse):
            postsList = apiResponse.posts.sorted(by: { $0.createdAt > $1.createdAt })
            //token = apiResponse.token
            print ("Posts recieved - new token: \(token)")
        case .failure(let error):
            print("Error getting posts: \(error)")
        }
    }
    func dateConverter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm dd MMMM YYYY" // change the date format of the posts here
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}

//struct PostView_Previews: PreviewProvider {
//    @State private static var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjYxZjk5MjY2ZDI3ZGFiODkzOTczMmQ1IiwiaWF0IjoxNzEzNDUxMDc1LCJleHAiOjE3MTM0NTE2NzV9.8Qm23P_G4AC-JW6TQ1YLnRQ9rPeGHy1UsKlgS7dakAI"
//    
//    static var previews: some View {
//        PostView(token: $token)
//    }
//}
