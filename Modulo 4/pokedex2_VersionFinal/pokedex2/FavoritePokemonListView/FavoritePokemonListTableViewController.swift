//
//  FavoritePokemonListTableViewController.swift
//  pokedex2
//
//  Created by Alejandro Mendoza on 25/11/23.
//

import UIKit

class FavoritePokemonListTableViewController: UITableViewController {

    let viewModel = FavoritePokemonListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: viewModel.favoriteCellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.present(UserAuthenticationViewController(), animated: true)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.favoriteCellIdentifier,
                                                 for: indexPath)
        let pokemon = viewModel.pokemon(at: indexPath)
        
        var cellConfiguration = cell.defaultContentConfiguration()
        cellConfiguration.text = pokemon.name
        
        cell.contentConfiguration = cellConfiguration
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let pokemon = viewModel.pokemon(at: indexPath)
        let favoriteDetailViewController = FavoritePokemonDetailViewController(pokemon: pokemon)
        navigationController?.pushViewController(favoriteDetailViewController, animated: true)
    }
}
