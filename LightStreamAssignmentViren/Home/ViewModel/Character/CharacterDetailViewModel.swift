//
//  CharacterDetailViewModel.swift
//  LightStreamAssignmentViren
//
//  Created by Patel, Viren on 10/9/22.
//

import Foundation

class CharacterDetailViewModel{
    private let model: Character
    
    init(_ model: Character) {
        self.model = model
    }
    
    func title() -> String {
        return model.name
    }
    
    func characterImageUrlString() -> String {
        return model.image
    }
    
    func namelabelText() -> String {
        return "Name:: \(model.name)"
    }
    
    func statusLabelText() -> String {
        return "Status:: \(model.status.rawValue)"
    }
    
    func originLabelText() -> String {
        return "Origin:: \(model.origin.name)"
    }
    
    func lastKnownlocationLabelText() -> String {
        return "Last known Location:: \(model.location.name)"
    }
    
    func genderLabelText() -> String {
        return "Gender:: \(model.gender.rawValue)"
    }
}
