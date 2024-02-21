import Foundation

struct PostResponseWrapper: Codable {
    let posts: [PostResponse]
}

class PostsViewModel: ObservableObject {
    @Published var posts: [PostResponse] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    var apiToken: String?
    
    init() {
        loadApiToken()
        fetchPosts()
       }
    
    
    func loadApiToken() {
        do {
            apiToken = try KeychainHelper.loadToken(account: "default")
        } catch {
            print("failed to load token")
        }
    }
    
    func deleteApiToken() {
        do {
            try KeychainHelper.deleteToken()
            print("Token deleted successfully")
        } catch {
            print("failed to delete token")
        }
    }
    
    func fetchPosts() {
        guard let url = URL(string: Constants.postsURL), let apiToken = apiToken else {
            return
        }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiToken)", forHTTPHeaderField: "Authorization")

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

}


