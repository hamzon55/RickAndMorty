import Combine

protocol RickAndMortyViewMdelTye: AnyObject {
    func transform(input: RickAndMortyViewModelInput) -> RickAndMortyViewModelOutput
    
}
enum RickAndMortyViewState {
    case idle
    case loading
    case succes([Character])
    case failure(String)
}

extension RickAndMortyViewState: Equatable {
    public static func == (lhs: RickAndMortyViewState, rhs: RickAndMortyViewState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.succes(let lhs), .succes(let rhs)):
            return lhs.elementsEqual(rhs) { $0.id == $1.id }
        case (.failure, .failure):
            return lhs == rhs
        default : return false
        }
    }
}

struct RickAndMortyViewModelInput {
    let appear: AnyPublisher<Void, Never>
    let disappear: AnyPublisher<Void, Never>
    let search: AnyPublisher<String, Never>
    
}

typealias RickAndMortyViewModelOutput = AnyPublisher<RickAndMortyViewState, Never>
