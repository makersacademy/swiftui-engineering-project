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
                let fetchedPosts = try JSONDecoder().decode([Post].self, from: data)
                DispatchQueue.main.async {
                    self.posts = fetchedPosts
                }
            } catch {
                print("Error decoding posts:", error)
            }
        }.resume()
    }

    func addPost(_ post: Post) {
        // Your add post logic here
    }
}

