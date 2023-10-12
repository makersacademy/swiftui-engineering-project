//
//  SwiftUIView.swift
//  MobileAcebook
//
//  Created by Alina Ermakova on 09/10/2023.
//

import PhotosUI
import SwiftUI
import Cloudinary

struct FeedView: View {
    
    @State var postTextField: String = ""
    @State var postArray: [String] = []
    private var service = FeedService()
    @State var posts = [Post]()
    @State var selectedItem: PhotosPickerItem? = nil
    @State var selectedImageData: Data = Data()
    
    var body: some View {
        TextField("Write a post", text: $postTextField)
            .padding()
            .foregroundColor(.black)
            .frame(width: 303, height: 36)
            .background(.white)
            .cornerRadius(6)
            .overlay(RoundedRectangle(cornerRadius: 6)
                .inset(by: 0.5)
                .stroke(Color(red: 0.16, green: 0.16, blue: 0.16).opacity(0.5), lineWidth: 1))
        PhotosPicker(
            selection: $selectedItem,
            matching: .images,
            photoLibrary: .shared()) {
                Text("Select a photo")
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                selectedImageData = data
                                print("image data \(selectedImageData)")
                            }
                        }
                    }
                    }
        Button(action: {
            if selectedItem == nil {
                createNewPost()
                guard let token = UserDefaults.standard.string(forKey: "token") else {
                    return
                }
                service.getAllPosts(token: token) { (posts, err) in
                    guard let posts = posts else {
                        // handle error
                        return
                    }
                    self.posts = posts.posts
                }
            } else {
                createNewPost(image: selectedImageData)
                guard let token = UserDefaults.standard.string(forKey: "token") else {
                    return
                }
                service.getAllPosts(token: token) { (posts, err) in
                    guard let posts = posts else {
                        // handle error
                        return
                    }
                    self.posts = posts.posts
                }
            }
            
        }, label: {
            Text("Post")
        })
        
        List(posts, id: \._id) { post in
            Text(post.message)
        }
        .onAppear {
            
            guard let token = UserDefaults.standard.string(forKey: "token") else {
                return
            }
            
            service.getAllPosts(token: token) { (posts, err) in
                guard let posts = posts else {
                    // handle error
                    return
                }
                self.posts = posts.posts
            }
        }
    }
    
    func createNewPost(image: Data = Data()) {
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            return
        }
        let post = CreatePost(image: image, message: postTextField)
        post.newPost(token: token)
    }
}

//struct FeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedView()
//    }
//}
