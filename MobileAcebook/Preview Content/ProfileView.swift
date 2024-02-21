

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
                        Button(action: {
                            isHouseClicked = true
                        }) {
                            Image(systemName: "house")
                                .foregroundColor(Color.gray)
                        }
                    }
                    Spacer()
                    Image(systemName: "play.tv")
                        .foregroundColor(Color.gray)
                    Spacer()
                    Image(systemName: "person.2")
                        .foregroundColor(Color.gray)
                    Spacer()
                    NavigationLink(destination: ProfileView(), isActive: $isPersonClicked) {
                        Button(action: {
                            isPersonClicked = true
                        }) {
                            Image(systemName: isPersonClicked ? "person.crop.circle" : "person.crop.circle.fill")
                                .foregroundColor(Color(UIColor(rgb: 0x316ff6)))
                        }
                    }
                    Spacer()
                    Image(systemName: "bell")
                        .foregroundColor(Color.gray)
                    Spacer()
                    Image(systemName: "line.3.horizontal")
                        .foregroundColor(Color.gray)
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
