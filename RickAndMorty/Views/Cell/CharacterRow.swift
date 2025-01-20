import SwiftUI

struct CharacterRow: View {
    
    let character: Character
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: character.image)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 90, height: 90)
            .clipShape(Circle())
            .shadow(radius: 2)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(character.name)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: true, vertical: false)
                Text(String(format: Constants.episodeCountFormat,
                            character.episode.count))
                .font(.subheadline)
                .foregroundColor(.gray)
            }
            Spacer().padding(.vertical, 8).frame(height: 100)
            
        }.padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .cornerRadius(8)
    }
}
