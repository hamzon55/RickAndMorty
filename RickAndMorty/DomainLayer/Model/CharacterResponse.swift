struct CharacterResponse: Codable {
    let info: Info
    let results: [Character]
    
    init(info: Info, results: [Character]) {
        self.info = info
        self.results = results
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.info = try container.decode(Info.self, forKey: .info)
        self.results = try container.decode([Character].self, forKey: .results)
    }
}

struct Info: Codable {
    let count, pages: Int
    let next: String?
    
    init(count: Int, pages: Int, next: String?) {
        self.count = count
        self.pages = pages
        self.next = next
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
        self.pages = try container.decode(Int.self, forKey: .pages)
        self.next = try container.decodeIfPresent(String.self, forKey: .next)
    }
    
}
