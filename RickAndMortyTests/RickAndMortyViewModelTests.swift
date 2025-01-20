import XCTest
import Combine
@testable import RickAndMorty

class RickAndMortyViewModelTests: XCTestCase {
    var mockUseCase: MockFetchCharacterUseCase!
    var viewModel: RickAndMortyViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockUseCase = MockFetchCharacterUseCase()
        viewModel = RickAndMortyViewModel(useCase: mockUseCase)
        cancellables = []
    }

    override func tearDown() {
        mockUseCase = nil
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }

    func testViewStateOnAppearSuccess() {
        let testResponse = CharacterResponse(
            info: Info(count: 1, pages: 1, next: nil),
            results: [
                Character(
                    id: 1,
                    name: "Rick Sanchez",
                    status: .alive,
                    gender: .male,
                    origin: Location(name: "Earth (C-137)", url: ""),
                    location: Location(name: "Earth", url: ""),
                    image: "",
                    episode: []
                )
            ]
        )
        mockUseCase.stubbedResponse = testResponse

        let input = RickAndMortyViewModelInput(
            appear: Just(()).eraseToAnyPublisher(),
            disappear: Empty().eraseToAnyPublisher(),
            search: Empty().eraseToAnyPublisher()
        )

        let expectation = self.expectation(description: "ViewModel updates to success state")
        
        viewModel.transform(input: input)
            .sink { state in
                if case let .success(characters) = state {
                    XCTAssertEqual(characters.count, 1)
                    XCTAssertEqual(characters.first?.name, "Rick Sanchez")
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}
