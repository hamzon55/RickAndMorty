import SwiftUI
import Combine
import Foundation
import RickAndMortyLibrary

class RickAndMortyViewModel: ObservableObject, RickAndMortyViewMdelTye {
    
    private var cancellables = Set<AnyCancellable>()
    private let useCase: FetchCharacterUseCase
    
    @Published var state: RickAndMortyViewState = .idle
    private var currentPage = 1
    private var allCharacters: [Character] = []
    
    init(useCase: FetchCharacterUseCase) {
        self.useCase = useCase
    }
    
    private func loadInitialPage() -> AnyPublisher<RickAndMortyViewState, Never> {
        currentPage = 1
        allCharacters = []
        state = .loading
        return fetchCharacters(page: currentPage, append: false)
    }
    
    private func loadNextPage() -> AnyPublisher<RickAndMortyViewState, Never> {
        currentPage += 1
        return fetchCharacters(page: currentPage, append: true)
    }
    
    private func handleSearch(query: String) -> AnyPublisher<RickAndMortyViewState, Never> {
        currentPage = 1
        allCharacters = []
        self.state = .loading
        return useCase.fetchCharacters(name: query, page: currentPage)
            .map { response in
                self.allCharacters = response.results
                return .success(self.allCharacters)
            }
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
                self?.loadInitialPage() ?? Just(.idle).eraseToAnyPublisher()
            }
        
        let loadNextPageResults = input.loadNextPage
            .flatMap { [weak self] _ -> AnyPublisher<RickAndMortyViewState, Never> in
                guard let self = self else { return Just(.idle).eraseToAnyPublisher() }
                return self.loadNextPage()
            }
            .eraseToAnyPublisher()
        
        let mergedResults = Publishers.Merge3(onAppearResults, searchResults, loadNextPageResults)
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] newState in
                self?.state = newState
            })
            .eraseToAnyPublisher()
        
        return RickAndMortyViewModelOutput(mergedResults)
    }
    
    private func fetchCharacters(page: Int, append: Bool) -> AnyPublisher<RickAndMortyViewState, Never> {
        useCase.fetchCharacters(name: nil, page: page)
            .map {  response in
                if append {
                    self.allCharacters += response.results
                } else {
                    self.allCharacters = response.results
                }
                return .success(self.allCharacters)
            }
            .catch { Just(.failure(self.mapError($0))) }
            .eraseToAnyPublisher()
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
