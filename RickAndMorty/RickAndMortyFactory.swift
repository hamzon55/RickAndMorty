import Foundation

struct RickAndMortyFactory {
    static func makeViewModel() -> RickAndMortyViewModel {
        let apiClient = URLSessionAPIClient<RickMortyEndpoint>()
        let useCase = DefaultRickMortyUseCase(apiClient: apiClient)
        return RickAndMortyViewModel(useCase: useCase)
    }
}
