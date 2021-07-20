//
//  ViewController.swift
//  To Do List
//
//  Created by Nate Howell on 7/19/21.
//

import UIKit
import RealmSwift

class ViewController: UITableViewController {
    
    var toDoItems: [Item] = []
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: call the refreshData() method here
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func refreshData() {
        // TODO: This is the method where you will update "toDoItems" with what currently in your database. Look up how to fetch realm data and do that here. This will require learning how to convert Results/List into an Array
    }
    
    func saveItem(text: String) {
        // TODO: This is the method where you will add an item to the Realm database with the given text. Make sure you call this where you have access to the textfields value
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { return UITableViewCell() }
        
        let item = toDoItems[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // TODO: Make the call to save the item to the database with the textfields value
            // TODO: Make sure to call the refreshData() method to keep your table view up to date with you Realm Database
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}

