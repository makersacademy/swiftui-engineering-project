import SwiftUI

struct FeedView: View {
    @ObservedObject private var postService = PostService()
    @ObservedObject private var authService = AuthenticationService()
    
    var body: some View {
        NavigationView {
            VStack {
                // Input field and share button
                TextField("What's happening?", text: $postService.newPostText)
                    .font(.body)
                    .padding(30)
                    .foregroundColor(Color.red)
                    .background(Color.yellow)
                    .cornerRadius(80)
                
                                Button(action: {
                                    // This is removed because we only want to fetch and display posts
                                }) {
                                    Text("Share")
                                }
                List(postService.posts) { post in
                    VStack(alignment: .leading, spacing: 8) {
                        // Display the username in a smaller font above the message
                        Text("Posted by \(post.createdBy.username) at \(post.createdAt)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        // Display the post message
                        Text(post.message)
                    }
                }
                .onAppear {
                    authService.getToken() { token in
                        if let token = token {
                            postService.fetchPosts(token: token)
                        } else {
                            print("Token is nil")
                        }
                    }
                }
                
                                                // Other views as needed
                                            }
                                            .navigationBarTitle("Feed")
                                        }
                                    }
                                }
            
