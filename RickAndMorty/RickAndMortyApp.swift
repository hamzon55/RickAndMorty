import SwiftUI
import Kingfisher

@main
struct RickAndMortyApp: App {
    init() {
        configureImageCache()
        
    }
    var body: some Scene {
        WindowGroup {
            CharactersListView(viewModel:
                                RickAndMortyFactory.makeViewModel())
        }
    }
    private func configureImageCache() {
        let cache = ImageCache.default
        cache.memoryStorage.config.totalCostLimit = 1024 * 1024 * 100
        cache.diskStorage.config.sizeLimit = 1024 * 1024 * 500
        cache.diskStorage.config.expiration = .days(7)
    }
}
