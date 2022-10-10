//
//  HomeViewOption.swift
//  LightStreamAssignmentViren
//
//  Created by Patel, Viren on 10/8/22.
//

import Foundation

struct HomeViewOption {
    let name: String
    let imageName: String
    let option: Option
}

extension HomeViewOption {
    enum Option{
        case characters
        case locations
    }
}

