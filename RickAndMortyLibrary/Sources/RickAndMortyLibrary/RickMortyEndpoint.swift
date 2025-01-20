import Foundation

public enum RickMortyEndpoint: APIEndpoint {
    
    case getCharacters(name: String?)
    
    public var baseURL: URL {
        return Constants.baseUrl
    }
    
    public var path: String {
        switch self {
        case .getCharacters:
            return Constants.characterPath
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .getCharacters:
            return .get
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case .getCharacters(let name):
            if let trimmedName = name?.trimmingCharacters(in: .whitespacesAndNewlines), !trimmedName.isEmpty {
                return ["name": trimmedName]
            }
            return nil
        }
    }
    
    
    public var headers: [String: String]? {
        switch self {
        case .getCharacters:
            return ["Content-Type": "application/json"]
        }
    }
}
