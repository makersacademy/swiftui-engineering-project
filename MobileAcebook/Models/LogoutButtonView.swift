////
////  LogoutButtonView.swift
////  MobileAcebook
////
////  Created by Dan Gullis on 21/02/2024.
////
//
//import SwiftUI
//
//struct LogoutButtonView: View {
//    @EnvironmentObject var authService: AuthenticationService
//
//    var body: some View {
//        Button("Logout") {
//            do {
//                try authService.signOut()
//            } catch {
//                print("failed to sign out \(error)")
//            }
//
//        }
//        .tabItem {
//            Label("Logout", systemImage: "person.fill.xmark")
//        }
//    }
//}
//struct LogoutButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        LogoutButtonView()
//    }
//}
