//
//  CreatePostView.swift
//  MobileAcebook
//
//  Created by Si on 21/02/2024.
//
import SwiftUI

struct CreatePostView: View {
    @State private var message: String = ""
    @State private var showingAlert = false // To control alert visibility
    @State private var alertTitle = "" // To set the alert title dynamically
    @State private var alertMessage = "" // To set the alert message dynamically

    var body: some View {
        VStack {
            TextField("Enter message here", text: $message)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Create Post") {
                CreatePostService.createPost(message: message) { success in
                    if success {
                        alertTitle = "Success"
                        alertMessage = "Your post has been successfully created."
                        print(alertMessage)
                        // Clear the message text field
                        message = ""
                    } else {
                        alertTitle = "Failure"
                        alertMessage = "Failed to create your post. Please try again."
                        print(alertMessage)
                    }
                    // Show the alert
                    showingAlert = true
                }
            }
        }
        .padding()
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView()
    }
}

