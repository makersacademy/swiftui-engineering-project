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
                // Deserialize JSON as a dictionary
                let json = try JSONDecoder().decode(PostResponse.self, from: data)
    
                //                     Assuming posts are stored under the key "posts" in the JSON
                //                    if let postsArray = json["posts"] as? [[String: Any]] {
                //                        // Now we need to append each post dictionary to the fetchedPosts array
                //                        var fetchedPosts: [[String: Any]] = []
                //                        for postDict in postsArray {
                //                            fetchedPosts.append(postDict)
                //                        }
                //
                //                        print("posts here", fetchedPosts)
                //                        print("posts here", postsArray)
                print("json here", json)
                // Assign fetchedPosts to self.posts here if needed
                //                    } else {
                //                        print("Posts array not found in JSON or has incorrect format")
                //                    }
                //            } else {
                //                    print("Invalid JSON format")
                
            } catch {
                print("Error decoding JSON:", error)
            }
        }.resume()
    }
    
    func addPost(_ post: Post) {
        // Your add post logic here
    }
    
}
