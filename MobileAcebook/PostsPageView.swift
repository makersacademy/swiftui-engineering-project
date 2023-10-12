//
//  PostsPageView.swift
//  MobileAcebook
//
//  Created by Alexander Wilson on 10/10/2023.
//

import SwiftUI

struct PostsPageView: View {
    @State private var userToken = UserDefaults.standard.string(forKey: "user-token")
    
    var body: some View {
        ScrollView {
            VStack{
                HStack{
                    Image("MageBook-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100.0, height: 100)
                        .accessibilityIdentifier("MageBook-logo")
                    Spacer()
                    Text("Your Magic Feed")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.trailing, 115)
                    
                }
                Spacer()
                
                VStack{
                    Image("MageBook-logo")
                }
                
                VStack{
                    Image("MageBook-logo")
                }
                
                VStack{
                    Image("MageBook-logo")
                }
            }
        }
    }
}

struct PostsPageView_Previews: PreviewProvider {
    static var previews: some View {
        PostsPageView()
    }
}
