import SwiftUI

struct CharacterEpisodesView: View {
    let character: Character
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Episodes")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.bottom, 8)
            
            ForEach(character.episode.indices, id: \.self) { index in
                EpisodeRow(episodeNumber: index + 1)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}
