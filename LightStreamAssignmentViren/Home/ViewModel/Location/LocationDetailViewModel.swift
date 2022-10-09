//
//  LocationDetailViewModel.swift
//  LightStreamAssignmentViren
//
//  Created by Patel, Viren on 10/9/22.
//

import Foundation

typealias CharactersForLocationResponse = () -> Void

class LocationDetailViewModel {
    private let model: Location
    var residents: [Character] = []
    
    init(_ model: Location) {
        self.model = model
    }
    
    func title() -> String {
        return model.name
    }
    
    func nameLabelText() -> String {
        return "Name:: \(model.name)"
    }
    
    func typeLabelText() -> String {
        return "Type:: \(model.type)"
    }
    
    func dimensionLabelText() -> String {
        return "Dimension:: \(model.dimension)"
    }
    
    func numberOfRows() -> Int {
        return residents.count
    }
    
    func resident(at indexpath: IndexPath) -> Character {
        return residents[indexpath.row]
    }
}

extension LocationDetailViewModel {
    func fetchCharactersForLocation(compeltion: @escaping CharactersForLocationResponse) {
        let dispatchGroup = DispatchGroup()
        var residents: [Character] = []
        for residentUrlString in model.residents {
            dispatchGroup.enter()
            let config = RequestConfig(apiEndpoint: residentUrlString)
            LSRequest(config) { data, response, error in
                if let error = error {
                    print("LocationDetailViewModel.fetchCharactersForLocation.Error:: \(error)")
                    dispatchGroup.leave()
                }
                guard let data = data else {
                    print("LocationDetailViewModel.fetchCharactersForLocation.Error:: Data Nil")
                    dispatchGroup.leave()
                    return
                }
                
                do {
                    let resident = try JSONDecoder().decode(Character.self, from: data)
                    residents.append(resident)
                    dispatchGroup.leave()
                } catch(let error) {
                    print("LocationDetailViewModel.fetchCharactersForLocation.Error:: \(error)")
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.residents = residents.sorted(by: {$0.name.lowercased() < $1.name.lowercased()})
            compeltion()
        }
    }
}
