
//  UserPageView.swift
//  MobileAcebook
//
//  Created by Dan Gullis on 20/02/2024.
//

import SwiftUI
import Cloudinary


struct UserPageView: View {
    let cloudinary = CLDCloudinary(configuration: CloudinaryConfig.configuration)

    var body: some View {
        NavigationView{
            VStack {
                HStack {
                    // replace image path with publicId of user image from sign up
                    cloudinaryImageView(cloudinary: cloudinary, imagePath: "acebook-mobile/Screenshot_2024-02-20_at_11.23.41_qd0jaw")

                    Text("username")
                }

                Spacer ()
            }
        }
    }

}



struct UserPageView_Previews: PreviewProvider {
    static var previews: some View {
        UserPageView()
    }
}

