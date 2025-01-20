import XCTest
import Foundation
@testable import RickAndMorty

final class CharacterModelTests: XCTestCase {

    func testCharacterDecoding() throws {
            let json = """
            {
                "id": 1,
                "name": "Rick Sanchez",
                "status": "Alive",
                "gender": "Male",
                "origin": { "name": "Earth (C-137)", "url": "https://rickandmortyapi.com/api/location/1" },
                "location": { "name": "Citadel of Ricks", "url": "https://rickandmortyapi.com/api/location/3" },
                "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                "episode": ["https://rickandmortyapi.com/api/episode/1"]
            }
            """.data(using: .utf8)!

            let character = try JSONDecoder().decode(Character.self, from: json)
            XCTAssertEqual(character.id, 1)
            XCTAssertEqual(character.name, "Rick Sanchez")
            XCTAssertEqual(character.status, .alive)
            XCTAssertEqual(character.gender, .male)
        }

    func testDecodeCharacterResponse() throws {
           let characterResponseJson = """
           {
             "info": {
               "count": 2,
               "pages": 1,
               "next": null
             },
             "results": [
               {
                 "id": 1,
                 "name": "Rick Sanchez",
                 "status": "Alive",
                 "gender": "Male",
                 "origin": { "name": "Earth (C-137)", "url": "" },
                 "location": { "name": "Earth", "url": "" },
                 "image": "",
                 "episode": ["https://rickandmortyapi.com/api/episode/1"]
               }
             ]
           }
           """.data(using: .utf8)!
           
           let response = try JSONDecoder().decode(CharacterResponse.self, from: characterResponseJson)
           
           XCTAssertEqual(response.info.count, 2)
           XCTAssertEqual(response.info.pages, 1)
           XCTAssertNil(response.info.next)
           XCTAssertEqual(response.results.count, 1)
           XCTAssertEqual(response.results.first?.name, "Rick Sanchez")
           XCTAssertEqual(response.results.first?.status, .alive)
           XCTAssertEqual(response.results.first?.gender, .male)
       }
   }
