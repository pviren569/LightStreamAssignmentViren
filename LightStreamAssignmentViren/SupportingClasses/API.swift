//
//  API.swift
//  LightStreamAssignmentViren
//
//  Created by Patel, Viren on 10/8/22.
//

import Foundation

struct API {
    private static var baseUTL: String {
        // Change this URL based on env QA/DEV/PROD
        return "https://rickandmortyapi.com/api"
    }
    
    public enum RickAndMorty {
        public static func character() -> String {
            return API.baseUTL + "/character"
        }
        
        public static func locations() -> String {
            return API.baseUTL + "/location"
        }
        
        public static func character(_ id: String) -> String {
            return API.RickAndMorty.character() + "/" + "\(id)"
        }
    }
}
