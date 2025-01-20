# RickAndMorty App

## Description
 A **SwiftUI** application that showcases characters from the *Rick and Morty* universe. The app demonstrates the use of **MVVM architecture**, **Combine**, **ViewState**, and **Kingfisher** for efficient image caching and asynchronous data handling.

## Features

   - Displays a list of characters fetched from the Rick and Morty API.
   - Includes a search bar for filtering characters by name.
   - Implements `NavigationLink` for transitioning to character details.

## Technologies Used

### 1. **SwiftUI**
   - Declarative UI framework for building responsive and modern user interfaces.

### 2. **Combine**
   - Framework for handling asynchronous data streams and event-driven programming.

### 3. **MVVM Architecture**
   - Model-View-ViewModel for clean separation of concerns:
     - `Model`: Represents the API data structures (`Character`, `CharacterResponse`).
     - `View`: Displays UI (`CharactersListView`, `CharacterHeaderView`).
     - `ViewModel`: Handles state, transforms inputs, and interacts with the use case (`RickAndMortyViewModel`).

## Installation
Clone the repository:
git clone https://github.com/hamzon55/RickAndMorty.git
cd RickAndMorty
Please run "pod install" in order to get all the dependencies.


## Architecture and implementation details
The application is written in SwiftUI and designed using MVVM architecture with Combine.


## Third party libraries
- SPM: RickAndMortyLibrary Includes the network Layer
- Kingfisher: Image loader and cache
