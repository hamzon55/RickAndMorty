import SwiftUI

struct CharacterEpisodesView: View {
    let character: Character
    let spaceMedium: CGFloat = 8

    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: spaceMedium) {
            Text(Constants.episodes)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.bottom, spaceMedium)
            
            ForEach(Array(character.episode.prefix(isExpanded ? character.episode.count : 0)
                .enumerated()), id: \.offset) { index, episode in
                    EpisodeRow(episodeNumber: index + 1)
                }
            
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                Text(isExpanded ? Constants.showLess : Constants.showMore)
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}
