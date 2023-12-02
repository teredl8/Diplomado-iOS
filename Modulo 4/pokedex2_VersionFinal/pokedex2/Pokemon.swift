//
//  Pokemon.swift
//  pokedex2
//
//  Created by Alejandro Mendoza on 17/11/23.
//

import Foundation

struct Pokemon: Codable, Hashable {
    struct Evolution: Codable {
        let name: String
        let num: String
    }
    
    struct Location: Codable {
        let latitude: Double
        let longitude: Double
    }
    
    let name: String
    let imageURL: String
    let id: Int
    let type: [String]
    let number: String
    let weight: String
    let height: String
    let weaknesses: [String]
    let previousEvolution: [Evolution]?
    let location: Location?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "img"
        case id
        case type
        case number = "num"
        case weight
        case height
        case weaknesses
        case previousEvolution = "prev_evolution"
        case location
    }
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
