import SwiftUI

struct PostView: View {
    let post: Post
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy, h:mm a"
        print(dateFormatter.string(from: post.createdAt))
        return dateFormatter.string(from: post.createdAt)
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(post.createdBy.username)")
                .font(.subheadline)
                .bold()
                .foregroundColor(.black)
            Text(formattedDate)
                    .font(.caption)
                    .foregroundColor(.gray)
            Divider()
            Text(post.message)
                .font(.headline)
            Divider()
        }
        .padding()
    }
}
