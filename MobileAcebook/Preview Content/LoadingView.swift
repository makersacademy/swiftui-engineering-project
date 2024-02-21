

import SwiftUI
import Foundation
struct LoadingView: View {
    var body: some View {

        Spacer()
        
        Image("logo-acebook")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .padding()
        
        Spacer()
        
        Text("from")
            .foregroundColor(Color(UIColor(rgb: 0x4267B2)))
        
        Image("makers-logo")
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .frame(width: 60, height: 60)
            .foregroundColor(Color(UIColor(rgb: 0x4267B2)))
        
    }
}
