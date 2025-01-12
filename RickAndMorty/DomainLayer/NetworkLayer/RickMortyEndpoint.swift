import Foundation

enum RickMortyEndpoint: APIEndpoint {
    
    case  getCharacters
    
    var baseURL: URL {
        return Constants.baseUrl
    }
    
    var path: String {
        switch self {
        case .getCharacters:
            return Constants.characterPath
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCharacters:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getCharacters:
            return nil
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getCharacters:
            return ["Content-Type": "application/json"]
        }
    }
}
