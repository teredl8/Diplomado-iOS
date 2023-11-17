//
//  PokemonListViewModel.swift
//  pokedex2
//
//  Created by Diplomado on 17/11/23.
//

// Función del ViewModel:
// Se comunica con el objeto y se lo da a la vista

import Foundation

class PokemonListViewModel {
    private let fileName = "pokemon_list"
    private let fileExtension = "json"
    
    init() {
        loadData()
    }
    
    private func loadData() {
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension),
        let pokemonData = try? Data(contentsOf: fileURL)
        else {
            assertionFailure("Cannot find file: \(fileName)")
            return
        }
        
        let decoder = JSONDecoder()
        do {
            let pokemonList = try decoder.decode([Pokemon].self, from: pokemonData)
        } catch {
            assertionFailure("\(error.localizedDescription)")
        }
    }
}


// Niveles de acceso en Swift:
// fileprive - permite verlo a cualquiera del mismo archivo
// private
// internal
// public
