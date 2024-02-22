
//  UserPageView.swift
//  MobileAcebook
//
//  Created by Dan Gullis on 20/02/2024.
//

import SwiftUI
import Cloudinary


struct UserPageView: View {
    @StateObject var authService = AuthenticationService.shared
    @StateObject var userPageViewModel = UserPageViewModel()
    
    
    let cloudinary = CLDCloudinary(configuration: CloudinaryConfig.configuration)

    var body: some View {
            VStack {
                if let error = userPageViewModel.errorMessage {
                    Text(error)
                }
                
                HStack {
                    if let avatar = userPageViewModel.user?.avatar {
                        cloudinaryImageView(cloudinary: cloudinary, imagePath: avatar)
                    }
                    
                    if let username = userPageViewModel.user?.username {
                        Text(username)
                    }
                }
                
                Text("Under development")

                Spacer ()
            }
            .onAppear {
                userPageViewModel.getUser()
            }
        }

}



struct UserPageView_Previews: PreviewProvider {
    static var previews: some View {
        UserPageView()
    }
}

