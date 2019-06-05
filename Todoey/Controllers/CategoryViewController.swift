//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Rosalie Wessels on 5/20/19.
//  Copyright © 2019 Rosalie Wessels. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit


class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categoryArray : Results<Category>?
    
    
    
    //MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: Any) {
        print("addButtonPressed")
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            //what happens once the user presses the alert
            print("button pressed")
            print("\(String(describing: textField.text)) needs to be added")
            if textField.text != "" {
                
                let newCategory = Category()
                
                newCategory.name = textField.text!
                
                self.save(category: newCategory)
                
            }
            self.tableView.reloadData()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
        tableView.rowHeight = 70.0

    }
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
//        cell.delegate = self
//        return cell
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories added yet"
        
        return cell
    }
    
    
    //MARK: - Data Manipulation Methods
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        }
        catch {
            print("error occured while saving Category Items : \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadCategories(){
        categoryArray = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }

}

//MARK: - Swipe Cell Delegate Methods

extension CategoryViewController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            print("Item Deleted")
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
}
