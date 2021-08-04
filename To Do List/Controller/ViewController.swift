//
//  ViewController.swift
//  To Do List
//
//  Created by Nate Howell on 7/19/21.
//

import UIKit
import RealmSwift

class ViewController: UITableViewController {
    
    var toDoItems = [Item?]()
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshData()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func refreshData() {
        
//        toDoItems = realm.objects(Item.self)
        
    }
    
    func saveItem(item: Item) {

            do {
                try realm.write {
//                    realm.add(item)
                }
            } catch {
                print("Error saving item \(error)")
            }

            tableView.reloadData()

    }
    
    // MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if let item = toDoItems[indexPath.row] {
            cell?.textLabel?.text = item.title
            cell?.accessoryType = item.done ? .checkmark : .none
        } else {
            cell?.textLabel?.text = "No Items added"
        }
//        cell.delegate = self
        return cell!
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = toDoItems[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }

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
            
            self.refreshData()
            
            self.saveItem(item: newItem)
        }
        
        
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            textField = alertTextField
            alertTextField.placeholder = "Create new item"
            
            
        }
    
        present(alert, animated: true, completion: nil)
        
    }
    


//MARK: - Swipe to Delete Method

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDoItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
            print("No items to delete")
        }
    }

}
