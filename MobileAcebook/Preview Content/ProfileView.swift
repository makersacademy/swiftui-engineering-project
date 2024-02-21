

import Foundation

import SwiftUI

struct ProfileView: View {
    @State private var isLoggedOut = false
    @State private var isPersonClicked = false
    @State private var isHouseClicked = false
    @State private var isDarkMode = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Text("My profile page")
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading:
                Image("facebook-name-logo")
                        .resizable()
                        .frame(width: 140, height: 30) 
                        .foregroundColor(isDarkMode ? .white : .black)
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isDarkMode.toggle()
                    }) {
                        Image(systemName: isDarkMode ? "sun.max.fill" : "sun.max")
                            .foregroundColor(Color(UIColor(rgb: 0x1877F2)))
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: LoginPage(authenticationService: AuthenticationService()), isActive: $isLoggedOut) {
                        Button(action: {

                            isLoggedOut = true
                        }) {
                            Image(systemName: isLoggedOut ? "rectangle.portrait.and.arrow.right.fill" : "rectangle.portrait.and.arrow.right")
                                .foregroundColor(Color(UIColor(rgb: 0x316ff6)))
                        }
                    }
                }
            }
            .environment(\.colorScheme, isDarkMode ? .dark : .light)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    NavigationLink(destination: FeedView(), isActive: $isHouseClicked) {
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
