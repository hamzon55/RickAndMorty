import Foundation

struct CharacterResponse: Codable {
    let info: Info
    let results: [Character]
    
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.info = try container.decode(Info.self, forKey: .info)
        self.results = try container.decode([Character].self, forKey: .results)
    }
}

struct Info: Codable {
    let count, pages: Int
    let next: String?
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
        self.pages = try container.decode(Int.self, forKey: .pages)
        next = try container.decodeIfPresent(String.self, forKey: .next)
    }
}
