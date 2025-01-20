import SwiftUI

struct EpisodeRow: View {
    let episodeNumber: Int

    var body: some View {
        HStack {
            Image(systemName: "tv")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(.blue)
                .padding(8)
                .background(Circle().fill(Color.blue.opacity(0.1)))
            
            Text("Episode \(episodeNumber)")
                .font(.headline)
                .foregroundColor(.primary)
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.1))
        )
        .shadow(radius: 1)
    }
}
