//
//  WelcomePageView.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 30/09/2023.
//

import SwiftUI
import PhotosUI
import Cloudinary


struct WelcomePageView: View {
    
    @StateObject var imagePicker = ImagePicker()
    @State private var uploadedImagePublicId: String?
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Spacer()
                    
                    Text("Welcome to Acebook!")
                        .font(.largeTitle)
                        .padding(.bottom, 20)
                        .accessibilityIdentifier("welcomeText")
                    
                    Spacer()
                    
                    Image("makers-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .accessibilityIdentifier("makers-logo")
                    
                    Spacer()
                    
                    NavigationLink("Sign Up", destination: SignupPageView())
                    
                    
                    NavigationLink("user page", destination: UserPageView())
                    
                    PhotosPicker(selection: $imagePicker.imageSelection) {
                        Text("upload a photo")
                    }
                    .onChange(of: imagePicker.imageData) { imageData in
                        // This block is executed when image data is set in the ImagePicker
                        // You can update the uploadedImagePublicId here
                        if let imageData = imageData {
                            imagePicker.uploadToCloudinary(data: imageData) { imagePublicId in
                                uploadedImagePublicId = imagePublicId
                            }
                        }
                    }
                    Spacer()
                    
                }
            }
        }
    }
}
struct WelcomePageView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePageView()
    }
}
