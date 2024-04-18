import Foundation
import Combine

class PostService: ObservableObject {
    @Published var posts: [Post] = []
    @Published var newPostText = ""
    
    func fetchPosts(token: String) {
        guard let url = URL(string: "http://localhost:3000/posts") else { return }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching posts:", error?.localizedDescription ?? "Unknown error")
                return
            }
            
            do {
                let postResponse = try JSONDecoder().decode(PostResponse.self, from: data)
                DispatchQueue.main.async {
                    self.posts = postResponse.posts // Update posts array with decoded posts
                }
            } catch {
                print("Error decoding JSON:", error)
            }
        }.resume()
    }
    
    func addPost(_ post: Post) {
        // Your add post logic here
    }
    
}
