//
//  LocationsInfo.swift
//  LightStreamAssignmentViren
//
//  Created by Patel, Viren on 10/9/22.
//

import Foundation

struct LocationsInfo: Codable {
    let Locations: [Location]
    
    enum CodingKeys: String, CodingKey  {
        case Locations = "results"
    }
}

// MARK: - Result
struct Location: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}
