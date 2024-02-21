//
//  FeedView.swift
//  MobileAcebook
//
//  Created by Gabriela Ehrenbrink on 20/02/2024.
//
import Foundation
import SwiftUI

struct FeedView: View {
//    var user: User?
    @State private var isLoggedOut = false
    @State private var isPersonClicked = false
    @State private var isHouseClicked = false
    var body: some View {
        
        NavigationView {
            VStack{
                List {
                    Text("Post 1")
                        .padding()
                    Text("Post 2")
                        .padding()
                    Text("Post 3")
                        .padding()
                    Text("Post 4")
                        .padding()
                    Text("Post 5")
                        .padding()
                    Text("Post 6")
                        .padding()
                    Text("Post 7")
                        .padding()
                    Text("Post 8")
                        .padding()
                    Text("Post 9")
                        .padding()
                    Text("Post 10") .padding()
                    Text("Post 11") .padding()
                    Text("Post 12") .padding()
                    Text("Post 13") .padding()
                    Text("Post 14") .padding()
                    Text("Post 15") .padding()
                    Text("Post 16") .padding()
                    Text("Post 17") .padding()
                    Text("Post 18") .padding()
                    Text("Post 19") .padding()
                    Text("Post 20") .padding()
                    Text("Post 21") .padding()
                }
            }
            .navigationTitle("Feed")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isLoggedOut = true
                        }) {
                            Image(systemName: isLoggedOut ? "sun.max.fill" : "sun.max")
                                .foregroundColor(Color(UIColor(rgb: 0x1877F2)))
                        }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: LoginPage(authenticationService: AuthenticationService()), isActive: $isLoggedOut) {
                        Button(action: {
                            isLoggedOut = true
                        }) {
                            Image(systemName: isLoggedOut ? "rectangle.portrait.and.arrow.right.fill" : "rectangle.portrait.and.arrow.right")
                                .foregroundColor(Color(UIColor(rgb: 0x1877F2)))
                        }
                    }
                }
                
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    NavigationLink(destination: FeedView(), isActive: $isHouseClicked) {
                        Button(action: {
                            isHouseClicked = true
                        }) {
                            Image(systemName: "house.fill")
                                .foregroundColor(Color(UIColor(rgb: 0x316ff6)))
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
                            Image(systemName: "person.crop.circle")
                                .foregroundColor(Color.gray)
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

        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct FeedViewPage_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
