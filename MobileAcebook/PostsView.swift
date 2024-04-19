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
    @State private var message: String = ""
    @State private var postsList = [Post]()
    @State private var userDetails: User? = nil
    private let postService: PostService = APIService()
    private let authenticationService: AuthenticationServiceProtocol = AuthenticationService()
    
    var body: some View {
        NavigationView{
            List
            {
                Group {
                    if let loggedInUser = userDetails {
                            Text("Logged in as \(loggedInUser.username)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        }
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
                                    self.token = newToken
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
                            
                        }
                    
                        .padding()
                }
            }.onAppear {postService.getPosts(JWTtoken: token, completion: handleGetPostsResult);  authenticationService.getUserInfo(JWTtoken: token, completion: handleGetUserResults)}
                .navigationTitle("Posts")
        }
    }
    
    func handleGetPostsResult(result: Result<PostAPIResponse, APIError>) {
        switch result {
        case .success(let apiResponse):
            postsList = apiResponse.posts.sorted(by: { $0.createdAt > $1.createdAt })
            token = apiResponse.token
            print ("Posts recieved - new token: \(token)")
        case .failure(let error):
            print("Error getting posts: \(error)")
        }
    } 
    func handleGetUserResults(result: Result<GetUserResponse, APIError>){
        print("Get User results called")
        switch result {
        case .success(let apiResponse):
            print("Api response - \(apiResponse)")
            userDetails = apiResponse.userData[0]
            print ("User details - \(userDetails as Any)")
        case .failure(let error):
            print("Error getting user details: \(error)")
        }
    }
    func dateConverter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm dd MMMM YYYY" // change the date format of the posts here
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}

struct PostView_Previews: PreviewProvider {
    @State private static var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjYxZDcxZGYzZWQyMDFmMWNjYTIwYzczIiwiaWF0IjoxNzEzNTE3MjkyLCJleHAiOjE3MTM1MTc4OTJ9.0Het7IxpI1B0I-UIEkY-EZm474ppIMejDGQl9baRpnU"
    
    static var previews: some View {
        PostView(token: $token)
    }
}
