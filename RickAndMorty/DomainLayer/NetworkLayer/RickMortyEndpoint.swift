import Foundation

enum RickMortyEndpoint: APIEndpoint {
    
    case getCharacters(name: String?)
    
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
        case .getCharacters(let name):
            if let trimmedName = name?.trimmingCharacters(in: .whitespacesAndNewlines), !trimmedName.isEmpty {
                return ["name": trimmedName]
            }
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
