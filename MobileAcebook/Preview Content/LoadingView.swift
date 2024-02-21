

import SwiftUI
import Foundation
struct LoadingView: View {
    var body: some View {

        Spacer()
        
        Image("makers-logo")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .foregroundColor(Color(UIColor(rgb: 0x4267B2))) 
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
