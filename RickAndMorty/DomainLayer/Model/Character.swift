struct Character: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let status: Status
    let gender: Gender
    let origin, location: Location
    let image: String
    let episode: [String]
    
    init(id: Int,
         name: String,
         status: Status,
         gender: Gender,
         origin: Location,
         location: Location,
         image: String,
         episode: [String]) {
        self.id = id
        self.name = name
        self.status = status
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.status = try container.decode(Status.self, forKey: .status)
        self.gender = try container.decode(Gender.self, forKey: .gender)
        self.origin = try container.decode(Location.self, forKey: .origin)
        self.location = try container.decode(Location.self, forKey: .location)
        self.image = try container.decode(String.self, forKey: .image)
        self.episode = try container.decode([String].self, forKey: .episode)
    }
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "unknown"
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        self = Gender(rawValue: value) ?? .unknown
    }
    
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
