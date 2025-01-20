import Foundation

public enum RickMortyEndpoint: APIEndpoint {
    
    case getCharacters(name: String?, page: Int?)

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
        case .getCharacters(let name, let page):
            var params: [String: Any] = [:]
            if let trimmedName = name?.trimmingCharacters(in: .whitespacesAndNewlines), !trimmedName.isEmpty {
                params["name"] = trimmedName
            }
            if let page = page {
                params["page"] = page
            }
            return params.isEmpty ? nil : params
        }
    }
    
    
    public var headers: [String: String]? {
        switch self {
        case .getCharacters:
            return ["Content-Type": "application/json"]
        }
    }
}
