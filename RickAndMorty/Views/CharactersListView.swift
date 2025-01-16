//
//  ContentView.swift
//  RickAndMorty
//
//  Created by HAMZA JERBI on 12/1/25.
//

import SwiftUI
import Combine

struct CharactersListView: View {
    @StateObject private var viewModel: RickAndMortyViewModel
    
    @State private var cancellables = Set<AnyCancellable>()
    @State private var searchName: String = ""
    @State private var searchStatus: String = ""
    
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
                        .scaleEffect(2)
                        .onAppear {
                            onAppearPublisher.send()
                        }
                    
                case .loading:
                    ProgressView(Constants.loadingCaracters)
                    
                case .succes(let characters):
                    List(characters) { character in
                        VStack(spacing: 0) {
                            NavigationLink(
                                destination: CharacterDetailView(character: character)
                            ) {
                                CharacterRow(character: character)
                                    .padding(.horizontal, 16)
                            }
                            Divider()
                        }
                        .listRowInsets(EdgeInsets())
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
                setupBindings()
            }.onDisappear() {
                onAppearPublisher.send()
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
