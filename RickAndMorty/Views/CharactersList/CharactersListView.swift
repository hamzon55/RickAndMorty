import SwiftUI
import Combine
import RickAndMortyLibrary
private enum Layout {
    enum Inset {
        static let rowLeadingInset: CGFloat = 16
        static let rowTrailingInset: CGFloat = 16
        static let scaleEffect: CGFloat = 2
    }
    enum Spacing {
        static let dividerSpacing: CGFloat = 0
    }
}
struct CharactersListView: View {
    @StateObject private var viewModel: RickAndMortyViewModel
    
    @State private var cancellables = Set<AnyCancellable>()
    @State private var searchName: String = ""
    
    private let onAppearPublisher = PassthroughSubject<Void,Never>()
    private let onDisappearPublisher = PassthroughSubject<Void,Never>()
    private let onSearchPublisher = PassthroughSubject<String, Never>()
    
    init(viewModel: RickAndMortyViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.state {
                    
                case .idle:
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(Layout.Inset.scaleEffect)
                        .onAppear {
                            onAppearPublisher.send()
                        }
                    
                case .loading:
                    ProgressView(Constants.loadingCaracters)
                    
                case .success(let characters):
                    List(characters) { character in
                        VStack(spacing: Layout.Spacing.dividerSpacing) {
                            NavigationLink(
                                destination: CharacterDetailView(character: character)
                            ) {
                                CharacterRow(character: character)
                            }
                            Divider()
                        }
                        .listRowInsets(EdgeInsets(
                            top: Layout.Spacing.dividerSpacing,
                            leading: Layout.Inset.rowLeadingInset,
                            bottom: Layout.Spacing.dividerSpacing,
                            trailing: Layout.Inset.rowTrailingInset
                        ))
                    }
                    .listStyle(PlainListStyle())
                    
                case .failure(let error):
                    VStack {
                        Text(Constants.errorLoading)
                            .font(.headline)
                            .foregroundColor(.red)
                        Text(error)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle(Constants.characters)
            .searchable(text: $searchName, prompt: Constants.search)
            .onChange(of: searchName) { oldValue, newValue in
                onSearchPublisher.send(newValue)
            }
            .onAppear {
                onAppearPublisher.send()
                setupBindings()
            }.onDisappear() {
                onDisappearPublisher.send()
            }
        }
    }
    
    private func setupBindings() {
        let input = RickAndMortyViewModelInput(
            appear: onAppearPublisher.eraseToAnyPublisher(),
            disappear: onDisappearPublisher.eraseToAnyPublisher(),
            search: onSearchPublisher.eraseToAnyPublisher())
        
        let output = viewModel.transform(input: input)
        output.receive(on: DispatchQueue.main)
            .sink(receiveValue: { state in
                viewModel.state = state
            })
            .store(in: &cancellables)
    }
}

#Preview {
    CharactersListView(viewModel: RickAndMortyFactory.makeViewModel())
}
