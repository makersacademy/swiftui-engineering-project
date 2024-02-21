

import Foundation

import SwiftUI

struct ProfileView: View {
    @State private var isLoggedOut = false
    @State private var isHouseClicked = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Text("My profile page")
                }
            }
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: FeedView(), isActive: $isHouseClicked) {
                        Button(action: {
                            // Action to perform for navigating to ProfileView
                            isHouseClicked = true
                        }) {
                            Image(systemName: isHouseClicked ? "house.fill" : "house")
                                .foregroundColor(.black)
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: LoginPage(authenticationService: AuthenticationService()), isActive: $isLoggedOut) {
                        Button(action: {
                            // Action to perform for logout
                            isLoggedOut = true
                        }) {
                            Image(systemName: isLoggedOut ? "rectangle.portrait.and.arrow.right.fill" : "rectangle.portrait.and.arrow.right")
                                .foregroundColor(.black)
                        }
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
