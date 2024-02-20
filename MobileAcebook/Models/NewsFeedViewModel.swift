//
//  NewsFeedViewModel.swift
//  MobileAcebook
//
//  Created by Demetrius Vissarion on 20/02/2024.
//

import Foundation
import Combine

class NewsFeedViewModel: ObservableObject {
    @Published var posts: [Post] = []
    private var cancellables = Set<AnyCancellable>()
    
    private let postService: PostServiceProtocol
    
    // Initialize with a PostServiceProtocol to allow for dependency injection and easier testing
    public init(postService: PostServiceProtocol = PostService()) {
        self.postService = postService
    }
    
    func fetchPosts() {
        // Assuming you have a method to retrieve or store the token securely
        // The token is now internally used within PostService, so no need to pass it here
        postService.fetchPosts { [weak self] posts, error in
            DispatchQueue.main.async {
                if let posts = posts {
                    self?.posts = posts
                } else if let error = error {
                    // Log the error or update the UI to reflect the failure
                    print("Error fetching posts: \(error.localizedDescription)")
                }
            }
        }
    }
}


