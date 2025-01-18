import SwiftUI

struct CharacterDetailView: View {
    @StateObject private var viewModel: CharacterDetailViewModel
    @State private var isEpisodesExpanded = false
    init(character: Character,
         episodeDetails: [String] = []) {
        _viewModel = StateObject(wrappedValue: CharacterDetailViewModel(character: character, episodeDetails: episodeDetails))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                CharacterHeaderView(character: viewModel.character)
                Divider()
                .padding(.horizontal)
                CharacterOriginLocationView(character: viewModel.character)
                Divider()
                .padding(.horizontal)
                CharacterEpisodesView(character: viewModel.character)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Character Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
