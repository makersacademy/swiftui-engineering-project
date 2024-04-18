import SwiftUI

struct PostsView: View {
    @State private var newPostText: String = ""
    @State private var posts: [Post] = []
    
    var body: some View {
        NavigationView {
            VStack {
                Image("makers-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(posts, id: \.id) { post in
                            PostView(post: post)
                        }
                    }
                    .padding()
                    
                }.refreshable {
                    fetchPosts()
                }
                
                HStack {
                    TextField("Write something...", text: $newPostText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button("Post") {
                        
                    }
                    .padding()
                }
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding()
            }
        }
        .onAppear {
            fetchPosts()
        }
    }
    private func fetchPosts() {
        PostService.shared.fetchPosts { fetchedPosts in
            self.posts = fetchedPosts
        }
    }
}
    struct PostsFeedView_Previews: PreviewProvider {
        static var previews: some View {
            PostsView()
        }
    }

