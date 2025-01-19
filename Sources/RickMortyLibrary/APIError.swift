import Foundation
public enum APIError: Error {
    case networkError(URLError)
    case decodingError(DecodingError)
    case invalidResponse
}
