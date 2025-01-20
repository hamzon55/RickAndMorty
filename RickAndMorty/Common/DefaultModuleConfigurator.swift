import Foundation
import RickAndMortyLibrary

protocol RickAndMortyModuleConfigurator {
    func configure() -> RickAndMortyViewModel
}

final class DefaultModuleConfigurator: RickAndMortyModuleConfigurator {
    
    func configure() -> RickAndMortyViewModel {
        
        let apiClient = URLSessionAPIClient<RickMortyEndpoint>()
        let useCase = DefaultRickMortyUseCase(apiClient: apiClient)
        let viewModel = RickAndMortyViewModel(useCase: useCase)
        
        return viewModel
    }
}
