import Combine
import Foundation
import RickAndMortyLibrary

protocol FetchCharacterUseCase {
    func fetchCharacters(name: String?, page: Int?) -> AnyPublisher<CharacterResponse, APIError>
}

final class DefaultRickMortyUseCase: FetchCharacterUseCase {

    public let apiClient: URLSessionAPIClient<RickMortyEndpoint>
    
    init(apiClient: URLSessionAPIClient<RickMortyEndpoint>) {
           self.apiClient = apiClient
       }
    
    func fetchCharacters(name: String?, page: Int?) -> AnyPublisher<CharacterResponse, RickAndMortyLibrary.APIError> {
        apiClient.request(RickMortyEndpoint.getCharacters(name: name, page: page))
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
