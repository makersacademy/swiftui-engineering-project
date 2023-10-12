//
//  PostsPageView.swift
//  MobileAcebook
//
//  Created by Alexander Wilson on 10/10/2023.
//

import SwiftUI

struct PostsPageView: View {
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
                
                // Create Post button
                HStack{
                    Spacer()
                    Button("Create post") {
                        var newPost = CreatePost(message: "First new post!")
                        createPost(newPost: newPost) { result in
                            switch result {
                            case .success:
                                print("New post created!")
                            case .failure(let error):
                                print("New post not created: \(error.localizedDescription)")
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .cornerRadius(20)
                    .frame(width: 150, height: 50)
                    .padding(.trailing, 90)
                    .tint(Color("Olivine"))
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
