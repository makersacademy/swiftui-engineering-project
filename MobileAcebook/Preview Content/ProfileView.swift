

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
                    Text("My profile page here")
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
