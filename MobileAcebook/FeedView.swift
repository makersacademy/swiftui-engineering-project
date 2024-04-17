import Foundation
import SwiftUI

struct FeedView: View {
  @ObservedObject private var postService = PostService()
  @ObservedObject private var authService = AuthenticationService()
    
  var body: some View {
    NavigationView {
      VStack {
        TextField("What's happening?", text: $postService.newPostText)
          .font(.body)
          .padding(30)
          .foregroundColor(Color.red)
          .background(Color.yellow)
          .cornerRadius(80)
        Spacer()
        Button(action: {
          guard !postService.newPostText.isEmpty else { return }
          let newPost = Post(
            id: UUID().uuidString,
            message: postService.newPostText,
            createdAt: Date(),
            createdBy: "User1", // Assuming "User1" is the user ID
            imgUrl: nil,
            likes: []
          )
          postService.addPost(newPost)
          postService.newPostText = ""
        }) {
          Text("Share")
        }
        .padding()
        List(postService.posts) { post in
          // Your post view code here
        }
        .padding(10)
        .navigationBarTitle("FakeBook")
        .onAppear {
            if let token = authService.getToken() {
                postService.fetchPosts(token: token)
            } else {
                print("Token is nil")
            }
        }
        Spacer()
      }
    }
  }
}
