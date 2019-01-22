//
//  ViewController.swift
//  ToDO
//
//  Created by JASANI HARDIK on 2019-01-21.
//  Copyright © 2019 JASANI HARDIK. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {
    
    var itemArray = ["Cake", "Pizza", "Bread"]
    let defaults = UserDefaults.standard
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = items
        }
        
    }
    
    //MARK - Tableview DataSource Methods

    
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
        
    }
    
    //MARK - Tableview Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     //   print(itemArray[indexPath.row])
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
       
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add New ToDo Items", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on our UIAlert
          //  print(textField.text)
            
            self.itemArray.append(textField.text!)
            
            self.defaults.setValue(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
        }
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
}

