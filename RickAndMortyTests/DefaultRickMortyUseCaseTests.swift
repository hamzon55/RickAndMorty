import XCTest
import Combine
@testable import RickAndMorty
import RickAndMortyLibrary
final class DefaultRickMortyUseCaseTests: XCTestCase {
    
        var useCase: DefaultRickMortyUseCase!
        var mockAPIClient: MockURLSessionAPIClient!
        var cancellables: Set<AnyCancellable>!
 
    override func setUp() {
         super.setUp()
         mockAPIClient = MockURLSessionAPIClient()
         useCase = DefaultRickMortyUseCase(apiClient: mockAPIClient)
         cancellables = []
     }
    
    override func tearDown() {
           useCase = nil
           mockAPIClient = nil
           cancellables = nil
           super.tearDown()
       }
    
    func testFetchCharactersSuccess() {
          let jsonData = """
          {
              "info": {
                  "count": 1,
                  "pages": 1,
                  "next": null
              },
              "results": [
                  {
                      "id": 1,
                      "name": "Rick Sanchez",
                      "status": "Alive",
                      "gender": "Male",
                      "origin": { "name": "Earth (C-137)", "url": "" },
                      "location": { "name": "Earth", "url": "" },
                      "image": "",
                      "episode": ["https://rickandmortyapi.com/api/episode/1"]
                  }
              ]
          }
          """.data(using: .utf8)!
          mockAPIClient.stubbedResult = .success(jsonData)
          let expectation = self.expectation(description: "Fetch characters success")
        
          useCase.fetchCharacters(name: "Rick")
              .sink(receiveCompletion: { completion in
                  switch completion {
                  case .finished:
                      break
                  case .failure:
                      XCTFail("Expected success, but got failure")
                  }
              }, receiveValue: { response in
                  XCTAssertEqual(response.results.count, 1)
                  XCTAssertEqual(response.results.first?.name, "Rick Sanchez")
                  XCTAssertEqual(response.results.first?.status, .alive)
                  XCTAssertEqual(response.results.first?.gender, .male)
                  expectation.fulfill()
              })
              .store(in: &cancellables)

          wait(for: [expectation], timeout: 1.0)
      }


}







