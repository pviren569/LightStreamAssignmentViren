//
//  Utility.swift
//  LightStreamAssignmentVirenTests
//
//  Created by Patel, Viren on 10/9/22.
//

import Foundation

class Utility {
    func getMockData(forResource: String) -> Data? {
        let currentBundle = Bundle(for: type(of: self))
        if let path = currentBundle.url(forResource: forResource, withExtension: "json") {
            do {
                return try Data(contentsOf: path)
            } catch {
                print("Unable to convert \(path) to Data.")
                return nil
            }
        } else {
            print("Unable to load \(forResource).json")
            return nil
        }
    }
}
