//
//  FavoritePokemonListViewModel.swift
//  pokedex2
//
//  Created by Alejandro Mendoza on 25/11/23.
//

import Foundation

class FavoritePokemonListViewModel {
    private var favoritePokemonList: Set<Pokemon> = []
    
    
    var numberOfRows: Int { favoritePokemonList.count }
    let numberOfSections: Int = 1
    let favoriteCellIdentifier: String = "favoritePokemonIdentifier"
    
    init() {
        loadFavoritePokemon()
    }
    
    func pokemon(at indexPath: IndexPath) -> Pokemon {
        let sortedFavoritePokemon = Array(favoritePokemonList).sorted { $0.id < $1.id }
        return sortedFavoritePokemon[indexPath.row]
    }
    
    private func loadFavoritePokemon() {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        let fileName = "favorite_pokemon_list.json"
        let favoritePokemonURL = documentDirectory.appending(path: fileName)
        
        do {
            
            let favoritePokemonData = try Data(contentsOf: favoritePokemonURL)
            let favoritePokemonList = try JSONDecoder().decode(Set<Pokemon>.self, from: favoritePokemonData)
            self.favoritePokemonList = favoritePokemonList
            
        } catch {
//            assertionFailure("cannot read data from \(fileName)")
        }
    }
}
