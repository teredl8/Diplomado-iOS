//
//  PokemonListViewModel.swift
//  pokedex2
//
//  Created by Tere Durán on 17/11/23.
//

// Función del ViewModel:
// Se comunica con el objeto y se lo da a la vista

import Foundation

class PokemonListViewModel {
    private let fileName = "pokemon_list"
    private let fileExtension = "json"
    
    private var pokemonList: [Pokemon] = []
    
    let pokemonCellIdentifier = "pokemonCell"
    
    let viewTitle = "Pokedex"
    
    let numberOfSections: Int = 1
    var numberOfRows: Int {pokemonList.count}
    
    init() {
        loadData()
    }
    
    func pokemon(at indexPath: IndexPath) -> Pokemon {
        pokemonList[indexPath.row]
    }
    
    private func loadData() {
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension),
        let pokemonData = try? Data(contentsOf: fileURL),
              let pokemonList = try? JSONDecoder().decode([Pokemon].self, from: pokemonData)
        else {
            assertionFailure("Cannot find file: \(fileName)")
            return
        }
        self.pokemonList = pokemonList
    }
}


// Niveles de acceso en Swift:
// fileprive - permite verlo a cualquiera del mismo archivo
// private
// internal
// public
