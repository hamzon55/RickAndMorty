import Foundation

struct Character: Codable {
    let id: Int
    let name: String
    let status: Status
    let species: Species
    let type: String
    let gender: Gender
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case status
        case species
        case type
        case gender
        case origin
        case location
        case image
        case episode
        case url
        case created
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.status = try container.decode(Status.self, forKey: .status)
        self.species = try container.decode(Species.self, forKey: .species)
        self.type = try container.decode(String.self, forKey: .type)
        self.gender = try container.decode(Gender.self, forKey: .gender)
        self.origin = try container.decode(Location.self, forKey: .origin)
        self.location = try container.decode(Location.self, forKey: .location)
        self.image = try container.decode(String.self, forKey: .image)
        self.episode = try container.decode([String].self, forKey: .episode)
        self.url = try container.decode(String.self, forKey: .url)
        self.created = try container.decode(String.self, forKey: .created)
    }
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
    
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let url: String
}

enum Species: String, Codable {
    case alien = "Alien"
    case human = "Human"
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
