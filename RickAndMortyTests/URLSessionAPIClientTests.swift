import XCTest
import Combine
@testable import RickAndMortyLibrary

final class URLSessionAPIClientTests: XCTestCase {
    var mockClient: MockAPIClient<MyEndpoint>!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockClient = MockAPIClient<MyEndpoint>()
        cancellables = []
    }

    override func tearDown() {
        mockClient = nil
        cancellables = nil
        super.tearDown()
    }

    func testSuccessfulResponse() {
        // Arrange
        let mockJSON = """
        {
            "id": 1,
            "name": "Test Item"
        }
        """
        let mockData = mockJSON.data(using: .utf8)!
        mockClient.mockResult = .success(mockData)

        let endpoint = MyEndpoint(
            baseURL: URL(string: "https://api.example.com")!,
            path: "test",
            method: .get,
            parameters: nil,
            headers: nil
        )

        // Act
        let expectation = self.expectation(description: "Successful response")
        mockClient.request(endpoint)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTFail("Expected success but got failure with error: \(error)")
                    }
                },
                receiveValue: { (response: MyResponseModel) in
                    // Assert
                    XCTAssertEqual(response.id, 1)
                    XCTAssertEqual(response.name, "Test Item")
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)

        waitForExpectations(timeout: 1.0)
    }

    func testFailureResponse() {
        // Arrange
        mockClient.mockResult = .failure(APIError.invalidResponse)

        let endpoint = MyEndpoint(
            baseURL: URL(string: "https://api.example.com")!,
            path: "test",
            method: .get,
            parameters: nil,
            headers: nil
        )

        // Act
        let expectation = self.expectation(description: "Failure response")
        mockClient.request(endpoint)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTAssertEqual(error as? APIError, APIError.invalidResponse)
                        expectation.fulfill()
                    }
                },
                receiveValue: { (_: MyResponseModel) in
                    XCTFail("Expected failure but got success")
                }
            )
            .store(in: &cancellables)

        waitForExpectations(timeout: 1.0)
    }
}


struct MyEndpoint: APIEndpoint {
    let baseURL: URL
    let path: String
    let method: HTTPMethod
    let parameters: [String: Any]?
    let headers: [String: String]?
}

struct MyResponseModel: Decodable {
    let id: Int
    let name: String
}

enum APIError: Error {
    case invalidResponse
}

   
