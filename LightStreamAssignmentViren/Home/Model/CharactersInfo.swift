//
//  CharactersInfo.swift
//  LightStreamAssignmentViren
//
//  Created by Patel, Viren on 10/9/22.
//

import Foundation

struct CharactersInfo: Codable {
    let characters: [Character]
    
    enum CodingKeys: String, CodingKey  {
        case characters = "results"
    }
}

// MARK: - Result
struct Character: Codable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let origin: Location
    let location: Location
    let gender: Gender
    let image: String
    let url: String
}

extension Character {
    enum Gender: String, Codable {
        case female = "Female"
        case male = "Male"
        case unknown = "unknown"
    }

    // MARK: - Location
    struct Location: Codable {
        let name: String
        let url: String
    }

    enum Status: String, Codable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
    }
}


