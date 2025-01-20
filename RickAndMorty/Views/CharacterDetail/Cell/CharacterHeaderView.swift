import SwiftUI
import Kingfisher

private enum Layout {
    enum Inset {
        static let spacingMedium: CGFloat = 16
        static let height = CGFloat(300)
        static let radius =  CGFloat(8)
        static let scaleEffect = CGFloat(1.5)
    }
}

struct CharacterHeaderView: View {
    let character: Character
    
    var body: some View {
        VStack(spacing: Layout.Inset.spacingMedium) {
            KFImage(URL(string: character.image))
                .placeholder {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(Layout.Inset.scaleEffect)
                }.retry(maxCount: 3, interval: .seconds(1))
                .cacheOriginalImage()
                .fade(duration: 0.25)
                .resizable()
                .scaledToFit()
                .cornerRadius(Layout.Inset.spacingMedium)
                .shadow(radius: Layout.Inset.radius)
                .frame(maxWidth: .infinity, maxHeight:  Layout.Inset.height)
            
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

