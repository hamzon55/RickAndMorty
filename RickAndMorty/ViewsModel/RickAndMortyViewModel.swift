import SwiftUI
import Combine
import Foundation
import RickMortyLibrary

class RickAndMortyViewModel: ObservableObject, RickAndMortyViewMdelTye {
    
    private var cancellables = Set<AnyCancellable>()
    private let useCase: FetchCharacterUseCase
    @Published var state: RickAndMortyViewState = .idle
    
    init(useCase: FetchCharacterUseCase) {
        self.useCase = useCase
    }
    
    private func handleSearch(query: String) -> AnyPublisher<RickAndMortyViewState, Never> {
        self.state = .loading
        return useCase.fetchCharacters(name: query)
            .map { .success($0.results) }
            .catch { Just(.failure(self.mapError($0))) }
            .eraseToAnyPublisher()
    }
    
    private func fetchCharacters() -> AnyPublisher<RickAndMortyViewState, Never> {
        useCase.fetchCharacters(name: nil)
            .map { .success($0.results) }
            .catch { Just(.failure(self.mapError($0))) }
            .eraseToAnyPublisher()
    }
    
    func transform(input: RickAndMortyViewModelInput) -> RickAndMortyViewModelOutput {
        
        cancellables.removeAll()
        
        let searchResults = input.search
            .flatMap { [weak self] query in
                self?.handleSearch(query: query) ??  Just(.idle).eraseToAnyPublisher()
            }
        
        let onAppearResults = input.appear
            .flatMap { [weak self] _ in
                self?.fetchCharacters() ?? Just(.idle).eraseToAnyPublisher()
            }
        
        let mergedResults = Publishers.Merge(onAppearResults, searchResults)
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] newState in
                self?.state = newState
            })
            .eraseToAnyPublisher()
        
        return RickAndMortyViewModelOutput(mergedResults)
        
    }
    
    private func mapError(_ error: APIError) -> String {
           switch error {
           case .networkError:
               return "Network connection issue."
           case .decodingError:
               return "Data parsing issue."
           case .invalidResponse:
               return "Invalid response from server."
           }
       }
}
