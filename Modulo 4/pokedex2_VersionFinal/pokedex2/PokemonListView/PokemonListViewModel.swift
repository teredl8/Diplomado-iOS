//
//  PokemonListViewModel.swift
//  pokedex2
//
//  Created by Alejandro Mendoza on 17/11/23.
//

import UIKit

protocol PokemonListViewModelDelegate: AnyObject {
    func shouldReloadTableData()
}

class PokemonListViewModel {
    private let fileName = "pokemon_list"
    private let fileExtension = "json"
    
    private var pokemonList: [Pokemon] = []
    private var filterPokemonList: [Pokemon] = []
    private var favoritePokemonList: Set<Pokemon> = []
    
    let pokemonCellIdentifier = "pokemonCell"
    
    let searchBarPlaceholder = "Search"
    let viewTitle = "Pokedex"
    
    let numberOfSections: Int = 1
    var numberOfRows: Int { filterPokemonList.count }
    
    weak var delegate: PokemonListViewModelDelegate?
    
    init() {
        loadData()
        loadFavoritePokemon()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(saveFavoritePokemon),
                                               name: UIApplication.willResignActiveNotification,
                                               object: nil)
    }
    
    func pokemon(at indexPath: IndexPath) -> Pokemon {
        filterPokemonList[indexPath.row]
    }
    
    private func loadData() {
        guard let fileURL = Bundle.main.url(forResource: fileName,
                                            withExtension: fileExtension),
              let pokemonData = try? Data(contentsOf: fileURL),
              let pokemonList = try? JSONDecoder().decode([Pokemon].self,
                                                          from: pokemonData)
        else {
            assertionFailure("Cannot find or read file: \(fileName)")
            return
        }
        
        self.pokemonList = pokemonList
        self.filterPokemonList = pokemonList
        
    }
    
    @objc
    private func saveFavoritePokemon() {
        // FileManager
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        let fileName = "favorite_pokemon_list.json"
        let fileURL = documentDirectory.appending(path: fileName)
        
        do {
            let favoritePokemonData = try JSONEncoder().encode(favoritePokemonList)
            let jsonFavoritePokemon = String(data: favoritePokemonData, encoding: .utf8)
            
            try jsonFavoritePokemon?.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            // assertionFailure("cannot encode favorite pokemon data")
        }
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
    
    
    func isFavorite(pokemon: Pokemon) -> Bool {
        favoritePokemonList.contains(pokemon)
    }
    
    func pokemonName(at indexPath: IndexPath) -> String {
        let pokemon = pokemon(at: indexPath)
        if isFavorite(pokemon: pokemon) {
            return pokemon.name + " ❤️"
        } else {
            return pokemon.name
        }
    }
    
    func filterPokemon(with searchText: String) {
        defer {
            delegate?.shouldReloadTableData()
        }
        
        guard !searchText.isEmpty else {
            filterPokemonList = pokemonList
            return
        }
        
        filterPokemonList = pokemonList.filter {
            $0.name.lowercased().contains(searchText.lowercased()) ||
            $0.number.lowercased().contains(searchText.lowercased())
        }
    }
    
    func addPokemonToFavorites(indexPath: IndexPath) {
        let favoritePokemon = filterPokemonList[indexPath.row]
        favoritePokemonList.insert(favoritePokemon)
        delegate?.shouldReloadTableData()
    }
}




