import Combine
import Foundation


protocol FetchCharacterUseCase {
    func fetchCharacters(name: String?) -> AnyPublisher<CharacterResponse, APIError>
}

final class DefaultRickMortyUseCase: FetchCharacterUseCase {
    
    private let apiClient: URLSessionAPIClient<RickMortyEndpoint>
    
    init(apiClient: URLSessionAPIClient<RickMortyEndpoint>) {
        self.apiClient = apiClient
    }
    
    func fetchCharacters(name: String? = nil) -> AnyPublisher<CharacterResponse, APIError> {
        apiClient.request(RickMortyEndpoint.getCharacters(name: name))
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

