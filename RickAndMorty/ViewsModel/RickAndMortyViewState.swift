import Combine

protocol RickAndMortyViewMdelTye: AnyObject {
    func transform(input: RickAndMortyViewModelInput) -> RickAndMortyViewModelOutput
    
}
enum RickAndMortyViewState {
    case idle
    case loading
    case success([Character])
    case failure(String)
}

extension RickAndMortyViewState: Equatable {
    public static func == (lhs: RickAndMortyViewState, rhs: RickAndMortyViewState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading):
             return true
        case (.success(let lhs), .success(let rhs)):
            return lhs.elementsEqual(rhs) { $0.id == $1.id }
        case (.failure(let lhsError), .failure(let rhsError)):
            return lhsError == rhsError
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
