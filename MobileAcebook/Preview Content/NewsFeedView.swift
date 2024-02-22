//
//  NewsFeedView.swift
//  MobileAcebook
//
//  Created by Demetrius Vissarion on 20/02/2024.
//

import Foundation
import SwiftUI

struct NewsFeedView: View {
    @ObservedObject var viewModel = NewsFeedViewModel()
    var postService: PostServiceProtocol

    // State variables to track fetch status and error messages
    @State private var isFetching = false
    @State private var fetchFailed = false
    @State private var errorMessage = ""

    var body: some View {
        NavigationView {
            // Use a ZStack to overlay status messages on top of the List
            ZStack {
                List(viewModel.posts) { post in
                    VStack(alignment: .leading) {
                        Text(post.message ?? "No message provided")
                            .font(.headline)
                        Text(post.image ?? "No image provided")
                            .font(.subheadline)
                    }
                }
                .navigationTitle("News Feed")
                .onAppear {
                    viewModel.fetchPosts()
                }

                // Conditionally display messages or errors
                if isFetching {
                    ProgressView("Fetching posts...")
                } else if fetchFailed {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else if viewModel.posts.isEmpty {
                    // No posts fetched
                    Text("No posts available.")
                }
            }
            .navigationTitle("News Feed")
            .onAppear {
                fetchPosts()
            }
        }
    }

    private func fetchPosts() {
        isFetching = true
        fetchFailed = false
        errorMessage = ""

        postService.fetchPosts { posts, error in
            DispatchQueue.main.async {
                self.isFetching = false

                if let error = error {
                    self.fetchFailed = true
                    self.errorMessage = "Failed to fetch posts: \(error.localizedDescription)"
                } else if let posts = posts, !posts.isEmpty {
                    self.viewModel.posts = posts
                } else {
                    // No error but also no posts
                    self.fetchFailed = true
                    self.errorMessage = "No posts found."
                }
            }
        }
    }
}


