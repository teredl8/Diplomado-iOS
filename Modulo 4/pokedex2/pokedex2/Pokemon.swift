//
//  Pokemon.swift
//  pokedex2
//
//  Created by Diplomado on 17/11/23.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let imageURL: String
    let id: Int
    let type: [String]
    let number: String
    let height: String
    let weight: String
    let weaknesses: [String]
    
    private enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "img"
        case id
        case type
        case number = "num"
        case height
        case weight
        case weaknesses
    }
}
