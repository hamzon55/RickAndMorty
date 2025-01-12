import Foundation

struct CharacterResults: Codable {
    let info: Info
    let results: [Character]
    
    enum CodingKeys: CodingKey {
        case info
        case results
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.info = try container.decode(Info.self, forKey: .info)
        self.results = try container.decode([Character].self, forKey: .results)
    }
   
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int
    let next: String
    
    enum CodingKeys: CodingKey {
        case count
        case pages
        case next
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
        self.pages = try container.decode(Int.self, forKey: .pages)
        self.next = try container.decode(String.self, forKey: .next)
    }
    
}
