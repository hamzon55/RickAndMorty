import Combine
import Foundation
import RickAndMortyLibrary
@testable import RickAndMorty

class MockFetchCharacterUseCase: FetchCharacterUseCase {
       
    var stubbedResponse: CharacterResponse?
    var stubbedError: APIError?

       func fetchCharacters(name: String?) -> AnyPublisher<CharacterResponse, APIError> {
           if let error = stubbedError {
               return Fail(error: error).eraseToAnyPublisher()
           }
           if let response = stubbedResponse {
               return Just(response)
                   .setFailureType(to: APIError.self)
                   .eraseToAnyPublisher()
           }
           fatalError("Stubbed response not set.")
       }
   }
