import SwiftUI

struct HomePageView: View {
    @StateObject var authService = AuthenticationService.shared
    @StateObject var logoutViewModel = LogoutViewModel()
    @ObservedObject var viewModel = PostsViewModel()
    @State private var isLoggingOut = false
    
    var body: some View {
        Group {
            if !authService.isLoggedIn {
                WelcomePageView()
            } else {
                
                TabView {
                    NavigationView {
                        
                        VStack {
                            List(viewModel.posts) { post in
                                VStack(alignment: .leading) {
                                    HStack {
                                        
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                            .foregroundColor(.blue)
                                            .padding(.trailing, 8)
                                        
                                        if let message = post.message {
                                            Text(message)
                                                .font(.subheadline)
                                        } else {
                                            Text("No message available")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    
                                    
                                    if let createdBy = post.createdBy {
                                        Text("Posted by: \(createdBy)")
                                            .font(.caption)
                                            .foregroundColor(.blue)
                                    }
                                    
                                    HStack {
                                        
                                        Button(action: {
                                            
                                        }) {
                                            Image(systemName: "heart")
                                                .foregroundColor(.red)
                                                .imageScale(.small)
                                        }
                                        .padding(.trailing, 8)
                                        Button(action: {
                                            
                                        }) {
                                            Label("Comments", systemImage: "bubble.left")
                                                .font(.caption)
                                        }
                                        .foregroundColor(.blue)
                                        .padding(.trailing, 16)
                                        
                                        
                                    }
                                    .padding(.top, 8)
                                    .padding(.bottom, 8)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    
                                    HStack {
                                        
                                    }
                                }
                                .padding()
                            }
                            
                            .padding()
                            Button {
                                logoutViewModel.signOut()
                            } label: {
                                Text("Log out")
                            }
                        }
                        .navigationBarTitle("Home Page")
                        .navigationBarTitleDisplayMode(.inline) // Center the title
                        .onAppear {
                            viewModel.loadApiToken()
                            viewModel.fetchPosts()
                            
                        }
                        

                    }
                    
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                    NavigationView {
                        UserPageView()
                    }
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("User")
                    }
                    NavigationView {
                        NewPostView()
                    }
                    .tabItem {
                        Label("New Post", systemImage: "pencil.line")
                    }
                    NavigationView {
                        EmptyView()
                    }
                    .tabItem{
                        Label("Logout", systemImage: "person.fill.xmark")
                            .onTapGesture {
                                isLoggingOut = true
                            }
                    }
                    
                }
                /*
                 Button("Log In") {
                     loginViewModel.logIn(email: emailAddress, password: password)
                     
                 }
                 .disabled(loginViewModel.isLoggingIn)
                 .background(NavigationLink(destination: HomePageView(), isActive: .constant(loginViewModel.successMessage != nil)) {
                         EmptyView()
                     })
                 */
                
            }
            
        }.navigationBarBackButtonHidden(true)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
            .environmentObject(AuthenticationService.shared)
    }
}
#endif
