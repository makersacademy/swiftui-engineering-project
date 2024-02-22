//
//  ProfileImageServices.swift
//  MobileAcebook
//
//  Created by Holly Page on 22/02/2024.
//

import Foundation
struct ProfilePictureView: View {
    @ObservedObject var viewModel = ProfilePictureView()
    
    if let avatarURL = loggedinUserModel.user?.avatar {
        RemoteImage(url: avatarURL)
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .accessibilityIdentifier("profile-picture")
            .overlay(alignment: .bottomTrailing) {
                PhotosPicker(selection: $viewModel.imageSelection,
                             matching: .images,
                             photoLibrary: .shared()) {
                    Image(systemName: "pencil.circle.fill")
                        .symbolRenderingMode(.multicolor)
                        .font(.system(size: 30))
                        .foregroundColor(.accentColor)
                }
                             .buttonStyle(.borderless)
            }
    } else {
        Image(systemName: "person.circle.fill") // Placeholder image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .foregroundColor(.gray)
            .overlay(alignment: .bottomTrailing) {
                PhotosPicker(selection: $viewModel.imageSelection,
                             matching: .images,
                             photoLibrary: .shared()) {
                    Image(systemName: "pencil.circle.fill")
                        .symbolRenderingMode(.multicolor)
                        .font(.system(size: 30))
                        .foregroundColor(.accentColor)
                }
                             .buttonStyle(.borderless)
            }
    }
        }
