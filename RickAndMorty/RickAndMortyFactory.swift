import Foundation
import RickAndMortyLibrary

struct RickAndMortyFactory {
    static func makeViewModel(
        with configurator: RickAndMortyModuleConfigurator = DefaultModuleConfigurator()
    ) -> RickAndMortyViewModel {
        return configurator.configure()
    }
}
