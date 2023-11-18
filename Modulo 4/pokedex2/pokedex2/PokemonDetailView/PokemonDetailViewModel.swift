//
//  PokemonDetailViewModel.swift
//  pokedex2
//
//  Created by Tere Durán on 17/11/23.
//

import UIKit

protocol PokemonDetailViewModelDelegate: AnyObject {
    func updatePokemonImage(to image: UIImage)
}

class PokemonDetailViewModel {
    private let pokemon: Pokemon
    
    var pokemonName: String { pokemon.name }
    var pokemonNumber: String { pokemon.number }
    
    weak var delegate: PokemonDetailViewModelDelegate?
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        if let pokemonImageURL = URL(string: pokemon.imageURL) {
            loadPokemonImage(from: pokemonImageURL)
        }
    }
    
    private func loadPokemonImage(from imageURL: URL) {
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: imageURL),
               let pokemonImage = UIImage(data: imageData) {
                
                DispatchQueue.main.async {
                    self?.delegate?.updatePokemonImage(to: pokemonImage)
                }
            }
        }
    }
}
