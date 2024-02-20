//  CloudinaryImageView.swift
//  MobileAcebook
//
//  Created by Dan Gullis on 20/02/2024.
//

import SwiftUI
import Cloudinary

func cloudinaryImageView(cloudinary: CLDCloudinary, imagePath: String) -> some View {
    VStack {
        if let cloudinaryURL = cloudinary.createUrl().generate(imagePath) {
            if let url = URL(string: cloudinaryURL) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipped()
                        .clipShape(Circle())

                } placeholder: {
                    ProgressView() // Show a progress view while the image is loading
                }
            } else {
                // Placeholder view if the URL is not valid
                Text("Invalid URL")
            }
        } else {
            Text("Image not found")
        }
    }
}
