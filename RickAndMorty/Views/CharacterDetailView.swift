//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by HAMZA JERBI on 16/1/25.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: character.image)) { image in
                image.resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 200)
        }.padding()
        .navigationBarTitle(character.name)
    }
}

//#Preview {
//CharacterDetailView(character: <#Character#>)
//}
