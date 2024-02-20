import SwiftUI

struct HomePageView: View {
    @ObservedObject var viewModel = PostsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    
                }) {
                    Text("What do you want to post...")
                        .foregroundColor(.blue)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding()
                
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
                .navigationBarTitle("Home Page")
                .navigationBarTitleDisplayMode(.inline) // Center the title
                .onAppear {
                    viewModel.fetchPosts()
                }
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
#endif



