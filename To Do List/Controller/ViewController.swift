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
        
        refreshData()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }
    
    func refreshData() {
        toDoItems = Array(realm.objects(Item.self))
        toDoItems.sort(by: { $0.dateCreated > $1.dateCreated }) // sort by dateCreated, newer items showing first
        toDoItems.sort(by: { item, _ in !item.done }) // sort by done, with not done items showing first
    }
    
    func saveItem(item: Item) {
            do {
                try realm.write {
                    realm.add(item)
                }
            } catch {
                print("Error saving item \(error)")
            }
        
            tableView.reloadData()
    }
    
    // MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.isEmpty ? 1 : toDoItems.count // if toDoItems is empty, show 1 cell with the "No items added" text
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { return UITableViewCell() }
        
        if toDoItems.isEmpty {
            cell.textLabel?.text = "No Items added"  // make sure there are items in the toDoItems array before selecting
        } else {
            let item = toDoItems[indexPath.row]
            
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        }
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard !toDoItems.isEmpty else { return } // make sure there are items in the toDoItems array before selecting
        
        let item = toDoItems[indexPath.row]
        do {
            try realm.write {
                item.done = !item.done
            }
        } catch {
            print("Error saving done status, \(error)")
        }
        
        refreshData()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
                        
            self.saveItem(item: newItem)
            self.refreshData()
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            textField = alertTextField
            alertTextField.placeholder = "Create new item"
            
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
}

