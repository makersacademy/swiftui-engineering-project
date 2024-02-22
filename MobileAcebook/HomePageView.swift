import SwiftUI

struct HomePageView: View {
    @StateObject var authService = AuthenticationService.shared
    @StateObject var logoutViewModel = LogoutViewModel()
    @ObservedObject var viewModel = PostsViewModel()
    @State private var isLoggingOut = false
    @State private var selectedTab = "Home"

    
    var body: some View {
        TabView(selection: $selectedTab) {
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
//                            Button {
//                                logoutViewModel.signOut()
//                            } label: {
//                                Text("Log out")
//                            }
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
                        // "New Post" tab content
                        Text("New Post Content")
                    }
                    .tabItem {
                        Label("New Post", systemImage: "pencil.line")
                    }
                    
                    Text("Logout")
                    .tag("Logout")
                    .tabItem {
                        Label("Logout", systemImage: "person.fill.xmark")
                    }
                    
                }
                .navigationBarBackButtonHidden(true)
                .onChange(of: selectedTab) { newValue in
                    if newValue == "Logout" {
                        logoutViewModel.signOut()
                        isLoggingOut = true
                    }
                }
                .background(NavigationLink(destination: WelcomePageView(), isActive: $isLoggingOut){ EmptyView() })
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
