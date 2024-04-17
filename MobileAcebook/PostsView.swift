////
////  PostsView.swift
////  MobileAcebook
////
////  Created by Alannah Lawlor on 16/04/2024.
////
//
import SwiftUI

struct PostView: View {
    @State var token: String = UserDefaults.standard.string(forKey: "AuthToken") ?? ""
    
    @State private var message: String = ""
    @State private var postsList = [Post]()
   private let postService: PostService = APIService()
    
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
                            postService.createPost(token: token, message: message) { result in
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
                            VStack {
                                Text( "\(post.message)").bold()
                                HStack{
                                    Text("\(post.createdBy["username"] ?? "")")
                                    Spacer()
                                    Text( "\(dateConverter(date: post.createdAt))")}
                            }
                            
                        }
                    
                        .padding()
                }
            }.onAppear {postService.getPosts(JWTtoken: token, completion: handleGetPostsResult)}
            .navigationTitle("Posts")
        }
    }
    func handleGetPostsResult(result: Result<PostAPIResponse, PostAPIError>) {
        print("Handle Get Posts Token")
        print(self.token)
        switch result {
        case .success(let apiResponse):
            postsList = apiResponse.posts.sorted(by: { $0.createdAt > $1.createdAt })
//            token = apiResponse.token
            print("handle Get Posts Token After")
            print ("Posts recieved - new token: \(token)")
        case .failure(let error):
            print("Error getting posts: \(error)")
        }
    }
    func dateConverter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm, dd MMMM YYYY" // change the date format of the posts here
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
