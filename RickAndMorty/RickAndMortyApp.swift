//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by HAMZA JERBI on 12/1/25.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    var body: some Scene {
        WindowGroup {
            CharactersListView(viewModel: RickAndMortyFactory.makeViewModel())

        }
    }
}
