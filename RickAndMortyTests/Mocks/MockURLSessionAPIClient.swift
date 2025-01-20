
import XCTest
import Combine
@testable import RickAndMortyLibrary

final class MockURLSessionAPIClient: URLSessionAPIClient<RickMortyEndpoint> {
    var stubbedResult: Result<Data, Error>?
    
    override func request<T: Decodable>(_ endpoint: RickMortyEndpoint) -> AnyPublisher<T, Error> {
        guard let result = stubbedResult else {
            return Fail(error: APIError.invalidResponse).eraseToAnyPublisher()
        }
        
        switch result {
        case .success(let data):
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return Just(decodedData)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } catch {
                return Fail(error: error).eraseToAnyPublisher()
            }
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
