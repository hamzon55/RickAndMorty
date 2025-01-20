import SwiftUI


private enum Layout {
    enum Frame {
        static let widthHeight: CGFloat = 30
        static let radius: CGFloat = 10
        static let minRadius: CGFloat = 1
        static let opacity: CGFloat = 0.1
    }
    enum Spacing {
        static let padding: CGFloat = 8

    }
}
struct EpisodeRow: View {
    let episodeNumber: Int

    var body: some View {
        HStack {
            Image(systemName: "tv")
                .resizable()
                .scaledToFit()
                .frame(width: Layout.Frame.widthHeight, height: Layout.Frame.widthHeight)
                .foregroundColor(.blue)
                .padding(Layout.Spacing.padding)
                .background(Circle().fill(Color.blue.opacity(Layout.Frame.opacity)))
            
            Text("Episode \(episodeNumber)")
                .font(.headline)
                .foregroundColor(.primary)
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: Layout.Frame.radius)
                .fill(Color.gray.opacity(Layout.Frame.opacity))
        )
        .shadow(radius: Layout.Frame.minRadius)
    }
}
