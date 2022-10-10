//
//  LightStreamAssignmentVirenTests.swift
//  LightStreamAssignmentVirenTests
//
//  Created by Patel, Viren on 10/8/22.
//

import XCTest
@testable import LightStreamAssignmentViren

final class HomeViewModelsTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCharacterTableViewModel() {
        guard let charactersInfoData = Utility().getMockData(forResource: "CharacterInfo") else {
            XCTFail("Unable to Get Data from CharacterInfo.json file")
            return
        }
        do {
            let jsonDecoder = JSONDecoder()
            let charactersInfo = try jsonDecoder.decode(CharactersInfo.self, from: charactersInfoData)
            let vm = CharacterTableViewModel(charactersInfo.characters)
            let character = vm.character(at: IndexPath(row: 5, section: 0))
            XCTAssertEqual(vm.characters.count, 20)
            XCTAssertEqual(character.name, "Abadango Cluster Princess")
        } catch  {
            XCTFail("Unable to parse Data from CharacterInfo.json file: \(error)")
        }
    }
    
    func testCharacterDetailViewModel() {
        guard let charactersInfoData = Utility().getMockData(forResource: "CharacterInfo") else {
            XCTFail("Unable to Get Data from CharacterInfo.json file")
            return
        }
        do {
            let jsonDecoder = JSONDecoder()
            let charactersInfo = try jsonDecoder.decode(CharactersInfo.self, from: charactersInfoData)
            let vm = CharacterDetailViewModel(charactersInfo.characters[10])
            XCTAssertEqual(vm.namelabelText(), "Name:: Albert Einstein")
            XCTAssertEqual(vm.title(), "Albert Einstein")
            XCTAssertEqual(vm.characterImageUrlString(), "https://rickandmortyapi.com/api/character/avatar/11.jpeg")
            XCTAssertEqual(vm.genderLabelText(), "Gender:: Male")
            XCTAssertEqual(vm.lastKnownlocationLabelText(), "Last known Location:: Earth (Replacement Dimension)")
            XCTAssertEqual(vm.originLabelText(), "Origin:: Earth (C-137)")
            XCTAssertEqual(vm.statusLabelText(), "Status:: Dead")
        } catch  {
            XCTFail("Unable to parse Data from CharacterInfo.json file: \(error)")
        }
    }
    
    func testLocationTableViewModel() {
        guard let locationsInfoData = Utility().getMockData(forResource: "LocationsInfo") else {
            XCTFail("Unable to Get Data from CharacterInfo.json file")
            return
        }
        do {
            let jsonDecoder = JSONDecoder()
            let locationsInfo = try jsonDecoder.decode(LocationsInfo.self, from: locationsInfoData)
            let vm = LocationTableViewModel(locationsInfo.Locations)
            let location = vm.location(at: IndexPath(row: 7, section: 0))
            XCTAssertEqual(vm.locations.count, 20)
            XCTAssertEqual(location.name, "Post-Apocalyptic Earth")
        } catch  {
            XCTFail("Unable to parse Data from LocationsInfo.json file: \(error)")
        }
    }
    
    func testLocationDetailViewModel() {
        guard let locationsInfoData = Utility().getMockData(forResource: "LocationsInfo") else {
            XCTFail("Unable to Get Data from CharacterInfo.json file")
            return
        }
        do {
            let jsonDecoder = JSONDecoder()
            let locationsInfo = try jsonDecoder.decode(LocationsInfo.self, from: locationsInfoData)
            let vm = LocationDetailViewModel(locationsInfo.Locations[9])
            XCTAssertEqual(vm.title(), "Venzenulon 7")
            XCTAssertEqual(vm.nameLabelText(), "Name:: Venzenulon 7")
            XCTAssertEqual(vm.numberOfRows(), 0)
            XCTAssertEqual(vm.dimensionLabelText(), "Dimension:: unknown")
            XCTAssertEqual(vm.typeLabelText(), "Type:: Planet")
        } catch  {
            XCTFail("Unable to parse Data from CharacterInfo.json file: \(error)")
        }
    }

}
