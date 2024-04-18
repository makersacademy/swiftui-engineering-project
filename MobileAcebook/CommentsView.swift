//
//  CommentsView.swift
//  MobileAcebook
//
//  Created by Amy Brown on 17/04/2024.
//

import Foundation
import SwiftUI

struct CommentsView: View {
    var post: Post
    @State var message = ""
    @State var token: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjYxZDcxZGYzZWQyMDFmMWNjYTIwYzczIiwiaWF0IjoxNzEzMzcxNzkzLCJleHAiOjE3MTMzNzc3OTN9.SPlKe097TAT3cobOe8qqdKjCW93XleB5eeDNVe5Xwrg"
    private let commentService: CommentService = CommentsAPIService()
    @State var commentsList = [Comment]()
    
    var body: some View {
        List{
            Section{
                VStack {
                    Spacer(minLength: 1)
                    Text( "\(post.message)").font(.headline)
                    Spacer(minLength: 1)
                    HStack{
                        Text("\(post.createdBy["username"] ?? "")") .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                        Text( "\(dateConverter(date: post.createdAt))") .font(.subheadline)
                        .foregroundColor(.gray)}
                }
            }
            Section(header: Text("Add new Comment")){
                VStack {
                    TextField("Add your message here", text: $message)
                    Button("Comment") {
                        guard !message.isEmpty else{
                                return
                            }
                        commentService.createComment(postId: post._id, token: token, message: message) { result in
                            switch result {
                            case .success(let newToken):
                                // Use the new token returned by the API
                                self.token = newToken
                                commentService.getComments(postId: post._id, JWTtoken: token, completion: handleGetCommentsResult)
                                print("New Comment Created - token updated to: \(newToken)")
                            case .failure(let error):
                                // Handle error
                                print("Error posting: \(error)")
                            }
                            message = ""
                        }
                    }
                    .accessibilityIdentifier("PostButton")
                }
            }
            Section(header: Text("Comments  (\(commentsList.count))")){
                ForEach(commentsList, id: \._id) { comment in
                            VStack {
                                Text( "\(comment.message)").bold()
                                HStack{
                                    Text("\(comment.createdBy["username"] ?? "")")
                                    Spacer()
                                    Text( "\(dateConverter(date: comment.createdAt))")}
                            }
                        
                    }
                
                    .padding()
            }.onAppear {commentService.getComments(postId: post._id, JWTtoken: token, completion: handleGetCommentsResult)}
                .navigationTitle("Comments")
        }
    }
    func handleGetCommentsResult(result: Result<CommentAPIResponse, APIError>) {
        switch result {
        case .success(let apiResponse):
            commentsList = apiResponse.comments.sorted(by: { $0.createdAt > $1.createdAt })
            token = apiResponse.token
            print ("Comments recieved - new token: \(token)")
        case .failure(let error):
            print("Error getting posts: \(error)")
        }
    }
    func dateConverter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm dd MMMM YYYY" // change the date format of the posts here
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
