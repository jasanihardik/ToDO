//
//  CategoryTableViewController.swift
//  ToDO
//
//  Created by JASANI HARDIK on 2019-02-21.
//  Copyright © 2019 JASANI HARDIK. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {

    
    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
      
    }
    
    //MARK: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
     
        cell.textLabel?.text =  categories[indexPath.row].name
        
        return cell
    }
    
    
    //MARK: - TableView Delegate Methods

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
           destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods
    
    func saveCategories() {
        
        
        
        do{
            try context.save()
        }
        catch {
            print("Error Saving Context\(error)")
        }
        
        
        self.tableView.reloadData()
        
    }
    
    
    
    func loadCategories() {
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error loading categories\(error)")
        }
        
        tableView.reloadData()
        
    }
    
    
    //MARK: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
            var textField = UITextField()
            
            
            let alert = UIAlertController(title: "Add New Categories", message: "", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
                //what will happen once the user clicks the Add Category button on our UIAlert
                //  print(textField.text)
                
                
                let newCategory = Category(context: self.context)
                
                newCategory.name = textField.text!
                
                
                self.categories.append(newCategory)
                
                self.saveCategories()
 
            }
            
            
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Create New Category"
                textField = alertTextField
                
                
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
            
     
        
    }
    
    
    
    
  
    
 
    
    
}
