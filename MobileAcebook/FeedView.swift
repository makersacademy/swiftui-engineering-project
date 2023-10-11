//
//  SwiftUIView.swift
//  MobileAcebook
//
//  Created by Alina Ermakova on 09/10/2023.
//

import SwiftUI

struct FeedView: View {
    
    var body: some View {
        if UserDefaults.standard.string(forKey: "token") != nil {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        } else {
            Text("Please login")
        }
    }
}

//struct FeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedView()
//    }
//}
