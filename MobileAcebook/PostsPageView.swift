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
                    Image("mage-hat-80s")
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

                
            ZStack{
                Rectangle()
                    .foregroundColor(Color("Magenta"))
                    .frame(width: 370, height: 338)
                    .background(Color(red: 0.9, green: 0.93, blue: 0.98))
                    .cornerRadius(40)
                VStack {
                    Rectangle()
                        .foregroundColor(Color(""))
                        .frame(width: 350, height: 268)
                        .background(
                            Image("buffycast")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 350, height: 268)
                                .clipped()
                        )
                        .background(.white)
                        .cornerRadius(30)
                    Text("Squad pic 🧛")
                        .fontWeight(.medium)
                        .font(.title3)
                        .foregroundColor(.black)
                }
            }
     
            
                    
            ZStack{
                Rectangle()
                    .foregroundColor(Color("Magenta"))
                    .frame(width: 370, height: 338)
                    .background(Color(red: 0.9, green: 0.93, blue: 0.98))
                    .cornerRadius(40)
                VStack {
                    Rectangle()
                        .foregroundColor(Color(""))
                        .frame(width: 350, height: 268)
                        .background(
                            Image("Gandalf-2")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 350, height: 268)
                                .clipped()
                        )
                        .background(.white)
                        .cornerRadius(30)
                    Text("I literally wasn't late though 🤬")
                        .fontWeight(.medium)
                        .font(.title3)
                        .foregroundColor(.black)
                    
                        
                }
            }
                
            ZStack{
                Rectangle()
                    .foregroundColor(Color("Magenta"))
                    .frame(width: 370, height: 338)
                    .background(Color(red: 0.9, green: 0.93, blue: 0.98))
                    .cornerRadius(40)
                VStack {
                    Rectangle()
                        .foregroundColor(Color(""))
                        .frame(width: 350, height: 268)
                        .background(
                            Image("gale")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 350, height: 268)
                                .clipped()
                        )
                        .background(.white)
                        .cornerRadius(30)
                    Text("Mystra snapped this lol ")
                        .fontWeight(.medium)
                        .font(.title3)
                        .foregroundColor(.black)
                }
            }
            
            ZStack{
                Rectangle()
                    .foregroundColor(Color("Magenta"))
                    .frame(width: 370, height: 338)
                    .background(Color(red: 0.9, green: 0.93, blue: 0.98))
                    .cornerRadius(40)
                VStack {
                    Rectangle()
                        .foregroundColor(Color(""))
                        .frame(width: 350, height: 268)
                        .background(
                            Image("ron")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 350, height: 268)
                                .clipped()
                        )
                        .background(.white)
                        .cornerRadius(30)
                    Text("Not me, not Hermione, YOU!")
                        .fontWeight(.medium)
                        .font(.title3)
                        .foregroundColor(.black)
                }
            }
            
            ZStack{
                Rectangle()
                    .foregroundColor(Color("Magenta"))
                    .frame(width: 370, height: 338)
                    .background(Color(red: 0.9, green: 0.93, blue: 0.98))
                    .cornerRadius(40)
                VStack {
                    Rectangle()
                        .foregroundColor(Color(""))
                        .frame(width: 350, height: 268)
                        .background(
                            Image("salem")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 350, height: 268)
                                .clipped()
                        )
                        .background(.white)
                        .cornerRadius(30)
                    Text("👻")
                        .fontWeight(.medium)
                        .font(.title3)
                        .foregroundColor(.black)
                }
            }


            }
        }
    }

struct PostsPageView_Previews: PreviewProvider {
    static var previews: some View {
        PostsPageView()
    }
}
