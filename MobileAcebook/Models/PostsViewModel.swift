import Foundation

struct PostResponseWrapper: Codable {
    let posts: [PostResponse]
}

class PostsViewModel: ObservableObject {
    @Published var posts: [PostResponse] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchPosts() {
        guard let url = URL(string: Constants.postsURL) else {
            return
        }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(Constants.apiToken)", forHTTPHeaderField: "Authorization")

        isLoading = true
        errorMessage = nil

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }

            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.errorMessage = error?.localizedDescription ?? "Unknown error"
                }
                return
            }

            do {
                let decodedPostsWrapper = try JSONDecoder().decode(PostResponseWrapper.self, from: data)
                
                DispatchQueue.main.async {
                    self.posts = decodedPostsWrapper.posts
                }
            } catch {
                print("Error decoding JSON: \(error)")
                DispatchQueue.main.async {
                    self.errorMessage = "Error decoding JSON: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}

struct Constants {
    static let postsURL = "http://127.0.0.1:8080/posts"
    static let apiToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MDg1MjM5OTAsImV4cCI6MTcwODUyOTk5MH0.KMAIm_dn0opPgBJ0MuMysoYnJ-PO2KtTQt-ycR4wfCc"
}

