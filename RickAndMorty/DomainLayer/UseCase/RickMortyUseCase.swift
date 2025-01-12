import Combine
import Foundation

// MARK: - UseCase

/// Protocol specifying the task to retrieve heroes.
protocol RickMortyUseCase {
    func fetchCharacters()  -> AnyPublisher<CharacterResults, APIError>
}

final class DefaultRickMortyUseCase: RickMortyUseCase {
    
    private let apiClient: URLSessionAPIClient<RickMortyEndpoint>
    
    /// - Parameter apiClient: The API client for making network requests.
    init(apiClient: URLSessionAPIClient<RickMortyEndpoint>) {
        self.apiClient = apiClient
    }
    
    /// Retrieves heroes based on the provided query.
    /// - Returns: A publisher emitting `MarvelResponse` or a `HeroUseCaseError` if an error occurs.
    
    func fetchCharacters() -> AnyPublisher<CharacterResults, APIError> {
        apiClient.request(RickMortyEndpoint.getCharacters)
            .mapError { error in
                if let urlError = error as? URLError {
                    return .networkError(urlError)
                } else if let decodingError = error as? DecodingError {
                    return .decodingError(decodingError)
                } else {
                    return .invalidResponse
                }
            }
            .eraseToAnyPublisher()
    }
}

