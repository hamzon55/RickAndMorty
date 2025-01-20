// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "RickAndMortyLibrary",
    platforms: [
        .iOS(.v14),
        .macOS(.v11)
    ],
    products: [
        // Exposes the library to other packages or projects
        .library(
            name: "RickAndMortyLibrary",
            targets: ["RickAndMortyLibrary"]
        ),
    ],
    dependencies: [
        // Add any external dependencies here
    ],
    targets: [
        // The main library target
        .target(
            name: "RickAndMortyLibrary",
            path: "Sources/RickAndMortyLibrary"
        ),
        // The test target
        .testTarget(
            name: "RickAndMortyLibraryTests",
            dependencies: ["RickAndMortyLibrary"],
            path: "Tests/RickAndMortyLibraryTests"
        ),
    ]
)