//
//  CategoryViewController.swift
//  shoppingList
//
//  Created by Oksana Malevich on 01.09.2020.
//  Copyright © 2020 Oksana Malevich. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    var category : Results <Category>?
    var selectedCategory = ""

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
        tableView.rowHeight = 60.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return category?.count ?? 1
   }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
     {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)

       cell.textLabel?.text = category?[indexPath.row].name ?? "No Category"
      return cell
 }
    
    
    
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add a New Cateogry", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            print ("Success")
            let newCategory = Category()
            newCategory.name = textField.text!
            self.save(category: newCategory)
          
    }
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new category"
        }
        present(alert, animated: true, completion: nil)
        tableView.reloadData()
        
    }
        
        
  
    
    
    
    override func tableView (_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "goToItems", sender: self)
        }

   
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destinationVC = segue.destination as! ShoppingListViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCategory = category?[indexPath.row]
            }

            }
        
   
    func save (category: Category) {
            do {
                try realm.write {
                    realm.add(category)
                    print("success save data")
                }
            } catch {
                print("Error saving category \(error)")
            }
           tableView.reloadData()
        }
    
   
    
    
    
    func load() {
        category = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.category?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error deleting category, \(error)")
            }
        }
    }
    
}


