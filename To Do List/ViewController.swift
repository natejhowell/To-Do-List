//
//  ViewController.swift
//  To Do List
//
//  Created by Nate Howell on 7/19/21.
//

import UIKit

class ViewController: UITableViewController {

    var toDoItems: Results<Item>?
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = super.tableView(tableView, cellForRowAt: indexPath)

        if let item = toDoItems?[indexPath.row]  {

            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }

        return cell
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
        var textField = UITextField()

    let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)

    let action = UIAlertAction(title: "Add", style: .default) { (action) in
    }

        alert.addTextField { (alertTextField) in
        alertTextField.placeholder = "Create new item"
        textField = alertTextField

    }

    alert.addAction(action)

    present(alert, animated: true, completion: nil)

}

}

