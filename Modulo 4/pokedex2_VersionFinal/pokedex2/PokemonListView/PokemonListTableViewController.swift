//
//  PokemonListTableViewController.swift
//  pokedex2
//
//  Created by Alejandro Mendoza on 17/11/23.
//

import UIKit

class PokemonListTableViewController: UITableViewController {

    let viewModel: PokemonListViewModel = PokemonListViewModel()
    
    private lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.hidesNavigationBarDuringPresentation = false
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = viewModel.searchBarPlaceholder
//        search.searchBar.delegate = self
        search.searchResultsUpdater = self
        
        
        
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, 
                           forCellReuseIdentifier: viewModel.pokemonCellIdentifier)
        
        title = viewModel.viewTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.searchController = searchController
        viewModel.delegate = self
    }

}

// MARK: - Tableview datasource
extension PokemonListTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.pokemonCellIdentifier,
                                                 for: indexPath)
        let pokemon = viewModel.pokemon(at: indexPath)
        
        var cellConfiguration = cell.defaultContentConfiguration()
        cellConfiguration.text = viewModel.pokemonName(at: indexPath)
        cellConfiguration.secondaryText = pokemon.number
        
        cell.contentConfiguration = cellConfiguration
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

// MARK: - tableview delegate
extension PokemonListTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let pokemon = viewModel.pokemon(at: indexPath)
        let pokemonDetailViewController = PokemonDetailViewController(pokemon: pokemon)
        navigationController?.pushViewController(pokemonDetailViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favoriteAction = UIContextualAction(style: .normal, title: "Add to favorites") { _, _, completion in
            self.viewModel.addPokemonToFavorites(indexPath: indexPath)
            completion(true)
        }
        
        favoriteAction.backgroundColor = .red
        favoriteAction.image = UIImage(systemName: "heart")
        
        return UISwipeActionsConfiguration(actions: [favoriteAction])
    }
}


//extension PokemonListTableViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        viewModel.filterPokemon(with: searchText)
//    }
//}

extension PokemonListTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
        viewModel.filterPokemon(with: searchText)
        viewModel.filterPokemon(with: searchText)
    }
}

extension PokemonListTableViewController: PokemonListViewModelDelegate {
    func shouldReloadTableData() {
        tableView.reloadData()
    }
}
