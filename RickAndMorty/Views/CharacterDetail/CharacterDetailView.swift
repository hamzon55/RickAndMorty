import SwiftUI
import RickAndMortyLibrary
struct CharacterDetailView: View {
    @StateObject private var viewModel: CharacterDetailViewModel
    @State private var isEpisodesExpanded = false
    private let spacing = CGFloat(16)
    
    init(character: Character,
         episodeDetails: [String] = []) {
        _viewModel = StateObject(wrappedValue:
                                    CharacterDetailViewModel(character:
                                                                character,
                                                             episodeDetails:
                                                                episodeDetails)
        )}
    
    var body: some View {
        ScrollView {
            VStack(spacing: spacing) {
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
        .navigationTitle(Constants.characterDetailTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}
