//
//  MyProfilePageView.swift
//  MobileAcebook
//
//  Created by Amy McCann on 19/02/2024.
//

import Foundation
import SwiftUI

struct MyProfilePageView: View {
    let layout = [
        GridItem(.flexible(minimum: 75)),
        GridItem(.flexible(minimum: 150))
    ]
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()

                Text("My Profile")
                    .font(.largeTitle)
                    .padding(.bottom, 20)
                    .accessibilityIdentifier("titleText")

                HStack{
                    Image("makers-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75, height: 100)
                        .accessibilityIdentifier("profile-picturem")
                    LazyVGrid(columns: layout, alignment: .leading, content: {
                        Text("Username:")
                        Text("Test Username")
                        Text("")
                        Text("")
                        Text("Email: ")
                        Text("TestEmailAddress")
                    })
        
                }
                Spacer()
                Text("Posts").font(.title)
                List{
                    Section () {
                        Text("Posts")
                    }
                }
            }
        }
    }
}

struct MyProfilePageView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfilePageView()
    }
}
