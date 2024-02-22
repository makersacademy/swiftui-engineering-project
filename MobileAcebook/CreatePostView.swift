//
//  CreatePostView.swift
//  MobileAcebook
//
//  Created by Si on 21/02/2024.
//
import SwiftUI

struct CreatePostView: View {
    @State private var message: String = ""
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 20) {
                    Spacer()
                    
                    Text("What's on your mind?").bold()
                    
                    TextField("Enter message here", text: $message)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button("Create Post") {
                        CreatePostService.createPost(message: message) { success in
                            if success {
                                alertTitle = "Success"
                                alertMessage = "Your post has been successfully created."
                                message = "" // Clear the message text field
                            } else {
                                alertTitle = "Failure"
                                alertMessage = "Failed to create your post. Please try again."
                            }
                            showingAlert = true // Show the alert
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 40)
                    .background(Color.black)
                    .cornerRadius(15.0)
                    .accessibilityIdentifier("createPostButton")
                    
                    Spacer()
                }
                .padding()
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
        .navigationBarHidden(true) // Ensure the navigation bar is hidden
    }
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView()
    }
}
