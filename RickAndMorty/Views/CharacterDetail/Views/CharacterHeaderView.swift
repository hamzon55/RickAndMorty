import SwiftUI

struct CharacterHeaderView: View {
    let character: Character
    
    var body: some View {
        VStack(spacing: 16) {
            AsyncImage(url: URL(string: character.image)) { image in
                image.resizable()
                    .scaledToFit()
                    .cornerRadius(16)
                    .shadow(radius: 8)
            } placeholder: {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)
            }
            .frame(maxWidth: .infinity, maxHeight: 300)
            
            Text(character.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .shadow(radius: 1)
            
            HStack(spacing: 20) {
                Label {
                    Text(character.status.rawValue)
                        .font(.headline)
                        .foregroundColor(character.status == .alive ? .green : .red)
                } icon: {
                    Image(systemName: character.status == .alive ? "heart.fill" : "xmark.circle")
                        .foregroundColor(character.status == .alive ? .green : .red)
                }
                Label {
                    Text(character.gender.rawValue)
                        .font(.headline)
                        .foregroundColor(.secondary)
                } icon: {
                    Image(systemName: "person.fill")
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

