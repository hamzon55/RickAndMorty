import SwiftUI

struct CharacterOriginLocationView: View {
    let character: Character
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Origin")
                .font(.title3)
                .fontWeight(.semibold)
            
            Text(character.origin.name)
                .font(.body)
                .foregroundColor(.secondary)
            
            Text("Last Known Location")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.top)
            
            Text(character.location.name)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}
