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

    // State variables to track fetch status and error messages
    @State private var isFetching = false
    @State private var fetchFailed = false
    @State private var errorMessage = ""
    @State private var isLoggedOut = false
    @State private var isPersonClicked = false
    @State private var isHouseClicked = false
    @State private var isDarkMode = false
    var postService: PostServiceProtocol
    let postServiceTwo = PostService()

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
            .onAppear {
                fetchPosts()
            }
            .background(Color(UIColor.systemBackground))
                        .navigationBarTitle("", displayMode: .inline)
                        .navigationBarItems(leading:
                            Image("facebook-name-logo")
                                    .resizable()
                                    .frame(width: 140, height: 30)
                                    .foregroundColor(isDarkMode ? .white : .black)
                        )
                        .toolbar {
                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                ZStack {
                                    Circle()
                                        .foregroundColor(Color.gray.opacity(0.3))
                                        .frame(width: 40, height: 40)
                                    
                                    Button(action: {isDarkMode.toggle()}) {
                                        Image(systemName: isDarkMode ? "sun.max.fill" : "sun.max")
                                            .foregroundColor(isDarkMode ? Color.white : Color.black)
                                    }
                                }
                                
                                ZStack {
                                    Circle()
                                        .foregroundColor(Color.gray.opacity(0.3))
                                        .frame(width: 40, height: 40)
                                    
                                    NavigationLink(destination: LoginPage(authenticationService: AuthenticationService()), isActive: $isLoggedOut) {
                                        Button(action: {
                                            isLoggedOut = true
                                        }) {
                                            Image(systemName: isLoggedOut ? "rectangle.portrait.and.arrow.right.fill" : "rectangle.portrait.and.arrow.right")
                                                .foregroundColor(isDarkMode ? Color.white : Color.black)
                                        }
                                    }
                                }
                            }

                        }
                        .environment(\.colorScheme, isDarkMode ? .dark : .light)
                        .toolbar {
                            ToolbarItemGroup(placement: .bottomBar) {
//                                NavigationLink(destination: NewsFeedView(postServiceTwo: postService), isActive: $isHouseClicked) {
                                    VStack {
                                        Image(systemName: "house.fill")
                                            .foregroundColor(Color(UIColor(rgb: 0x316ff6)))
                                        Text("Home")
                                            .font(.caption)
                                    }
//                                }
                                Spacer()
                                VStack {
                                    Image(systemName: "play.tv")
                                        .foregroundColor(Color.gray)
                                    Text("Video")
                                        .font(.caption)
                                }
                                Spacer()
                                VStack {
                                    Image(systemName: "person.2")
                                        .foregroundColor(Color.gray)
                                    Text("Friends")
                                        .font(.caption)
                                }
                                Spacer()
                                NavigationLink(destination: ProfileView(), isActive: $isPersonClicked) {
                                    VStack {
                                        Image(systemName: "person.crop.circle")
                                            .foregroundColor(Color.gray)
                                        Text("Profile")
                                            .font(.caption)
                                            .foregroundColor(Color.black)
                                    }
                                }
                                Spacer()
                                VStack {
                                    Image(systemName: "bell")
                                        .foregroundColor(Color.gray)
                                    Text("Notifs")
                                        .font(.caption)
                                }
                                Spacer()
                                VStack {
                                    Image(systemName: "line.3.horizontal")
                                        .foregroundColor(Color.gray)
                                    Text("Menu")
                                        .font(.caption)
                                }
                            }
                        }

                    }
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
        
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


//struct NewsFeedViewPage_Previews: PreviewProvider {
//    static var previews: some View {
//        NewsFeedView()
//    }
//}
//struct NewsFeedViewPage_Previews: PreviewProvider {
//    static var previews: some View {
//        NewsFeedView(postService: PostService())
//    }
//}
