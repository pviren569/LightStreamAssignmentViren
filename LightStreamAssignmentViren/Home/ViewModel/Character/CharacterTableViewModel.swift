//
//  CharacterTableViewModel.swift
//  LightStreamAssignmentViren
//
//  Created by Patel, Viren on 10/9/22.
//

import Foundation

class CharacterTableViewModel {
    typealias CharactersResponse = (Error?) -> Void
    var characters: [Character] = []
    
    init(_ characters: [Character] = []) {
        self.characters = characters
    }
    
    func fetchCharacters(completion: @escaping CharactersResponse) {
        let request = RequestConfig(apiEndpoint: API.RickAndMorty.character())
        LSRequest(request) { data, response, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                return completion(error)
            }
            
            do {
                let characterInfo = try JSONDecoder().decode(CharactersInfo.self, from: data)
                let characters = characterInfo.characters.sorted(by: {$0.name.lowercased() < $1.name.lowercased()})
                self.characters = characters
                completion( nil)
            } catch(let error) {
                completion(error)
            }
        }
    }
    
    func character(at indexPath: IndexPath) -> Character {
        return characters[indexPath.row]
    }
}
