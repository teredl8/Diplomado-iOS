//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Tere Durán on 01/12/23.
//

import UIKit

class ViewController: UIViewController {
    
    let restClient = RESTClient<PaginatedResponse<Character>>(client: Client("https://rickandmortyapi.com"))
    var characters: [Character]? {
        didSet {
            table.reloadData()
        }
    }
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        restClient.show("/api/character/") { response in
            //response.results
            self.characters = response.results
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        cell.textLabel?.text = characters?[indexPath.row].name
        cell.detailTextLabel?.text = characters?[indexPath.row].species
        
        return cell
    }
}
