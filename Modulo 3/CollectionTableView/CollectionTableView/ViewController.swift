//
//  ViewController.swift
//  CollectionTableView
//
//  Created by Tere Durán on 03/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    var dataArray = ["Primero", "Segundo", "Tercero"]
    var filterArray: [String] = []
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterArray = dataArray
        table.dataSource = self
        searchBar.delegate = self
    }

    @IBAction func sortButton(_ sender: Any) {
        if table.isEditing {
            table.isEditing = false
        } else {
            table.isEditing = true
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filterArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = table.dequeueReusableCell(withIdentifier: "cell")
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = filterArray[indexPath.row]
        return cell!
    }
    
    //True para editar
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        filterArray.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterArray = []
        
        if searchText == "" {
            filterArray = dataArray
        }
        
        for word in dataArray {
            //Uppercased da la cadena en mayúsculas
            if word.uppercased().contains(searchText.uppercased()) {
                filterArray.append(word)
            }
        }
        table.reloadData()
    }
}

