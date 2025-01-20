import Foundation
import Combine

class CharacterDetailViewModel: ObservableObject {
    
        @Published var character: Character
        @Published var episodeDetails: [String]
        
        init(character: Character, episodeDetails: [String] = []) {
            self.character = character
            self.episodeDetails = episodeDetails
        }
        
        func updateEpisodeDetails(_ details: [String]) {
            self.episodeDetails = details
        }
    }

