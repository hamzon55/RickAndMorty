import SwiftUI
import RickAndMortyLibrary

private enum Layout {
    enum Frame {
        static let widthHeight: CGFloat = 90
        static let heightVertical: CGFloat = 100
        static let radius: CGFloat = 2
    }
    enum Spacing {
        static let horizontal: CGFloat = 16
        static let vertical: CGFloat = 5
        static let padding: CGFloat = 8

    }
}

struct CharacterRow: View {
    
    let character: Character
    
    var body: some View {
        HStack(spacing: Layout.Spacing.horizontal) {
            AsyncImage(url: URL(string: character.image)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: Layout.Frame.widthHeight, height: Layout.Frame.widthHeight)
            .clipShape(Circle())
            .shadow(radius: Layout.Frame.radius)
            
            VStack(alignment: .leading, spacing: Layout.Spacing.vertical) {
                Text(character.name)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: true, vertical: false)
                Text(String(format: Constants.episodeCountFormat,
                            character.episode.count))
                .font(.subheadline)
                .foregroundColor(.gray)
            }
            Spacer().padding(.vertical, Layout.Spacing.padding).frame(height: Layout.Frame.heightVertical)
            
        }.padding(.vertical, Layout.Spacing.padding)
            .frame(maxWidth: .infinity)
            .cornerRadius(Layout.Spacing.padding)
    }
}
