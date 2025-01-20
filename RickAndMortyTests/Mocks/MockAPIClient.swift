import XCTest
import Combine
import Foundation
@testable import RickAndMortyLibrary

// MARK: - MockAPIClient
class MockAPIClient<EndpointType: APIEndpoint>: APIClient {
    var mockResult: Result<Data, Error>?
    
    func request<T>(_ endpoint: EndpointType) -> AnyPublisher<T, Error> where T: Decodable {
        guard let mockResult = mockResult else {
            return Fail(error: APIError.invalidResponse).eraseToAnyPublisher()
        }
        
        switch mockResult {
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
