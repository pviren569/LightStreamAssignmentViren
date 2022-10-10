//
//  LocationTableViewModel.swift
//  LightStreamAssignmentViren
//
//  Created by Patel, Viren on 10/9/22.
//

import Foundation

class LocationTableViewModel{
    typealias LocationsResponse = (Error?) -> Void
    var locations: [Location] = []
    
    init(_ locations: [Location] = []) {
        self.locations = locations
    }
    
    func fetchLocations(completion: @escaping LocationsResponse) {
        let config = RequestConfig(apiEndpoint: API.RickAndMorty.locations())
        
        LSRequest(config) { data, response, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                return completion(error)
            }
            
            do {
                let locationInfo = try JSONDecoder().decode(LocationsInfo.self, from: data)
                let locations = locationInfo.Locations.sorted(by: {$0.name.lowercased() < $1.name.lowercased()})
                self.locations = locations
                completion( nil)
            } catch(let error) {
                completion(error)
            }
        }
    }
    
    func location(at indexPath: IndexPath) -> Location {
        return locations[indexPath.row]
    }
}
