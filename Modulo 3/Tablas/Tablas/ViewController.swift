//
//  ViewController.swift
//  Tablas
//
//  Created by Diplomado on 27/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstTableView: UITableView! {
        didSet {
            firstTableView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        }
    }
    
    @IBOutlet weak var textField: UITextField!
    
    let model = TableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        firstTableView.delegate = self
    }


    @IBAction func addButton(_ sender: Any) {
        model.addRow(text: textField.text ?? "")
        firstTableView.reloadData()
    }
}

//Ctrl + shift: editar varias lineas al mismo tiempo
//IndexPath tienen fila y sección
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Celdas resusables
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MyTableViewCell
        
        cell?.title.text = model.getTitle(index: indexPath)
        cell?.myDescription.text = model.getDescription(index: indexPath)
        
        switch indexPath.section {
        case 1: cell?.backgroundColor = .blue
        case 2: cell?.backgroundColor = .brown
        default: cell?.backgroundColor = .orange
        }
        
        /*
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        
        cell?.backgroundColor = .gray
        cell?.accessoryType = .disclosureIndicator
        cell?.textLabel?.text = model.getTitle(index: indexPath)
        cell?.detailTextLabel?.text = model.getDescription(index: indexPath)
        */
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return model.getCountArray()
        case 1: return 1
        default: return 2
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        model.getSectionTitle()
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        "Delete"
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            model.deleteRow(index: indexPath)
            tableView.reloadData()
            
        }
    }
    
}

//Se puede agregar secciones en la tabla para que cada una funcione por separado

extension ViewController: UITableViewDelegate {
    /*func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        150.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80.0
    }*/
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(model.getTitle(index: indexPath))
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "TableToNextView", sender: nil)
    }
}
