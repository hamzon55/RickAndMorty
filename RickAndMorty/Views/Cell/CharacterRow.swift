import SwiftUI

struct CharacterRow: View {
    let character: Character
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: character.image)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 80)
            .clipShape(Circle())
            .shadow(radius: 2)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(character.name)
                    .font(.headline)
                    .lineLimit(1)
                Text(character.status.rawValue.capitalized)
                    .font(.subheadline)
                    .foregroundColor(character.status == .alive ? .green : .red)
            }
            
            Spacer().padding(.vertical, 8).frame(height: 100)
            
        }.padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .cornerRadius(8)
    }
}
