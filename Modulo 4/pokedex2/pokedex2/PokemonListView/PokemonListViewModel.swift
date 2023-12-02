//
//  PokemonListViewModel.swift
//  pokedex2
//
//  Created by Tere Durán on 17/11/23.
//

// Función del ViewModel:
// Se comunica con el objeto y se lo da a la vista

import Foundation

protocol PokemonListViewModelDelegate: AnyObject {
    func shouldReloadTableData()
}

class PokemonListViewModel {
    private let fileName = "pokemon_list"
    private let fileExtension = "json"
    
    private var pokemonList: [Pokemon] = []
    var filterPokemonList: [Pokemon] = []
    
    let pokemonCellIdentifier = "pokemonCell"
    
    let searchBarPlaceholder = "Search"
    let viewTitle = "Pokedex"
    
    let numberOfSections: Int = 1
    var numberOfRows: Int { filterPokemonList.count }
    
    weak var delegate: PokemonListViewModelDelegate?
    
    init() {
        loadData()
    }
    
    func pokemon(at indexPath: IndexPath) -> Pokemon {
        filterPokemonList[indexPath.row]
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
        self.filterPokemonList = pokemonList
    }
    
    func filterPokemon(with searchText: String) {
        // Cuando se termina de ejecutar el método se hace lo que está en defer
        defer {
            delegate?.shouldReloadTableData()
        }
        
        guard !searchText.isEmpty else {
            filterPokemonList = pokemonList
            return
        }
        
        filterPokemonList = pokemonList.filter {
            $0.name.lowercased().contains(searchText.lowercased()) || $0.number.lowercased().contains(searchText.lowercased())
        }
    }
}


// Niveles de acceso en Swift:
// fileprive - permite verlo a cualquiera del mismo archivo
// private
// internal
// public
