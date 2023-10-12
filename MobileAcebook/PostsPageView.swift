//
//  PostsPageView.swift
//  MobileAcebook
//
//  Created by Alexander Wilson on 10/10/2023.
//

import SwiftUI

struct PostsPageView: View {
    @State private var userToken = UserDefaults.standard.string(forKey: "user-token")
    @State private var newPostMessage: String = ""

    
    var body: some View {
        ScrollView {
            VStack{
                HStack{
                    Image("MageBook-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100.0, height: 100)
                        .accessibilityIdentifier("MageBook-logo")
                    //Spacer()
                    Text("Your Magic Feed")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.trailing, 115)
                    
                }
                Spacer()
                
                // Create post field and button
                VStack{
                    TextField("Scribe a message here...", text: $newPostMessage)
                        .padding(5)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 300)
                    HStack {
                        Spacer()
                        ZStack {
                            Button("Post", systemImage: "wand.and.stars") {
                                let newPost = CreatePost(message: newPostMessage)
                                createPost(newPost: newPost) { result in
                                    switch result {
                                    case .success:
                                        print("New post created")
                                        newPostMessage = ""
                                    case .failure(let error):
                                        print("New post not created: \(error.localizedDescription)")
                                    }
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            .cornerRadius(20)
                            .tint(Color("Olivine"))
                        }
                        .frame(width: 110) // Set the width of the container
                        .padding(.trailing, 90)
                    }
                }
            }
            .frame(width: 500)

                
                VStack{
                    Image("MageBook-logo")
                }
                
                VStack{
                    Image("MageBook-logo")
                }
                
                VStack{
                    Image("MageBook-logo")
                }
            }
        }
    }

struct PostsPageView_Previews: PreviewProvider {
    static var previews: some View {
        PostsPageView()
    }
}
