//
// SignupPageView.swift
// MobileAcebook
//
// Created by Joshua Bhogal on 19/02/2024.
//

import SwiftUI
import PhotosUI
import Cloudinary

struct SignupPageView: View {
  @State private var username: String = ""
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var confPassword: String = ""
    @StateObject var authService = AuthenticationService.shared

  @StateObject var imagePicker = ImagePicker()
  @State private var uploadedImagePublicId: String = "/default_avatar.png"
    
  @State private var navigateToFeedPage: Bool = false

  var body: some View {
      VStack{

        Text("Welcome to Acebook!")
          .font(.largeTitle)
          .padding(.bottom, 20)
          .accessibilityIdentifier("welcomeText")

        Spacer()

        Image(systemName: "network")
              .resizable()
              .scaledToFit()
              .frame(width: 200, height: 200)
              .accessibilityIdentifier("network-logo")

        Form {
          Section(header: Text("Sign Up")
            .font(.title2)
            .multilineTextAlignment(.center)) {
              TextField("Username", text:$username)
              TextField("Email", text:$email)
              SecureField("Password", text:$password)
              SecureField("Confirm Password", text:$confPassword)
            }

            PhotosPicker(selection: $imagePicker.imageSelection) {
                Text("Upload a photo")
            }
            .onChange(of: imagePicker.imageData) { imageData in
                // This block is executed when image data is set in the ImagePicker
                // You can update the uploadedImagePublicId here
                if let imageData = imageData {
                    imagePicker.uploadToCloudinary(data: imageData) { imagePublicId in
                        if let imagePublicId = imagePublicId {
                            uploadedImagePublicId = imagePublicId
                        } else { /*look here later*/
                            print("Error: Image upload failed.")
                        }
                    }
                }
            }
            
            
          Section {

            Button("Sign up") {
              let userInfo = User(email: email, username: username, password: password, avatar: uploadedImagePublicId)
                authService.signUp(user: userInfo, confPassword: confPassword) {
                    canSignUp in if canSignUp {
                        print("line 74 \(navigateToFeedPage)")
                        navigateToFeedPage = true
                    } else {
                        print("line 77 \(canSignUp)")
                        navigateToFeedPage = false
                    }
                }
            }.background(NavigationLink(destination: LoginPageView(), isActive: $navigateToFeedPage){ EmptyView() })
          }
        }
        Spacer()
      }
  }
}

struct SignupPageView_Previews: PreviewProvider {
    static var previews: some View {
        SignupPageView()
            .environmentObject(AuthenticationService.shared)
    }
}

