

import Foundation

import SwiftUI

struct ProfileView: View {
    @State private var isLoggedOut = false
    @State private var isPersonClicked = false
    @State private var isHouseClicked = false
    let postService = PostService()
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    // profile page layout design goes inside this scrollView (not outside it) so that it is visible between the upper and lower nav
                    VStack(spacing: 0) {
//                        color for now but should be an image uploaded by user
                        Color(UIColor(rgb: 0x4267B2)).frame(height: UIScreen.main.bounds.height / 4)
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 150, height: 150)

                            Image(systemName: "person")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
//                                .clipShape(Circle())
                                .frame(width: 120, height: 120)
                        }
                        .offset(y: -60)
                        VStack {
                            Text("John Smith") // Replace with user's name
                                        .font(.headline)
                                        .foregroundColor(.black)

                            Text("john@email.com") // Replace with user's email
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                
                        }
                        .frame(width: 300, height: 100)
                        .background(Color.gray.opacity(0.06))
                        .cornerRadius(10)
                        .offset(y: -30)
                        VStack {
                            Text("My Posts")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .bold()
//                            Add Posts from user

                            
                        }
                        .frame(width: 300, height: 100)
                        .offset(y: -30)
                    }

                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading:
                Image("facebook-name-logo")
                        .resizable()
                        .frame(width: 140, height: 30) 
                        
            )
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    ZStack {
                        Circle()
                            .foregroundColor(Color.gray.opacity(0.3))
                            .frame(width: 40, height: 40)
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color.black)
                        
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
                                    .foregroundColor( Color.black)
                            }
                        }
                    }
                }

            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    NavigationLink(destination: NewsFeedView(postService: postService), isActive: $isHouseClicked) {
                        VStack {
                            Image(systemName: "house")
                                .foregroundColor(Color.gray)
                            Text("Home")
                                .font(.caption)
                                .foregroundColor(Color.black)
                        }
                    }
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
                            Image(systemName: isPersonClicked ? "person.crop.circle" : "person.crop.circle.fill")
                                .foregroundColor(Color(UIColor(rgb: 0x316ff6)))
                            Text("Profile")
                                .font(.caption)
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

            .background(
                NavigationLink(destination: LoginPage(authenticationService: AuthenticationService()), isActive: $isLoggedOut) { EmptyView() }
            )
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}



struct ProfileViewPage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
