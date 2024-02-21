

import Foundation
import SwiftUI

struct LoginView: View {
    @State private var isSignupViewPresented = false
    let authService = AuthenticationService()
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                Text("Log in form")
                    .font(.largeTitle)
                    .padding(.bottom, 20)
                
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
