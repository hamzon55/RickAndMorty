import SwiftUI
import RickAndMortyLibrary

struct CharacterOriginLocationView: View {
    let character: Character
    let leadingSpacing: CGFloat = 8

    var body: some View {
        VStack(alignment: .leading, spacing: leadingSpacing) {
            Text(Constants.origin)
                .font(.title3)
                .fontWeight(.semibold)
            
            Text(character.origin.name)
                .font(.body)
                .foregroundColor(.secondary)
            
            Text(Constants.lastLocation)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.top)
            
            Text(character.location.name)
                .font(.body)
                .foregroundColor(.secondary)
            
            Text(Constants.gender)
                .font(.title3)
                .fontWeight(.semibold)
            
            Text(character.gender.rawValue)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}
