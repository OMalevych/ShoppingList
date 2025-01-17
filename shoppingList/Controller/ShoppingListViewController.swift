//
//  ViewController.swift
//  shoppingList
//
//  Created by Oksana Malevich on 30.08.2020.
//  Copyright © 2020 Oksana Malevich. All rights reserved.
//

import UIKit
import RealmSwift

class ShoppingListViewController: SwipeTableViewController, UISearchBarDelegate {

    
    
   let realm = try! Realm()
    
    var shoppingItems : Results <Item>?
    var selectedCategory : Category?{
        didSet{
            loadItems()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingItems?.count ?? 1
    }
    
    
      
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
         
            {
                    let cell = super.tableView(tableView, cellForRowAt: indexPath)

                   if  let item = shoppingItems?[indexPath.row]{
                                   cell.textLabel?.text = item.title
                                   cell.accessoryType = item.done ? .checkmark : .none
                               } else {
                                   cell.textLabel?.text = "No Items Added"
                               }
            
                  return cell
             }
            
           
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(shoppingItems?[indexPath.row])
        
        if let item = shoppingItems?[indexPath.row] {
        do {
            try realm.write{
                // realm.delete(item)
                item.done = !item.done
            }
        } catch {
            print("Error saving done status, \(error)")
        
            }
        }
            tableView.reloadData()
        
            tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60.0
    }

    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
         var textField = UITextField()
               let alert = UIAlertController(title: "Add New Item To Your Shopping List", message: "", preferredStyle: .alert)// making alert popup window
        let action = UIAlertAction(title: "Add New Item", style: .default){ (action) in
            print ("Success")
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new items, \(error)")
                }
            }
            self.tableView.reloadData()
           
        }
    
    alert.addTextField { (alertTextField) in
        alertTextField.placeholder = "Create New Item"
        textField = alertTextField
        
        
    }
    alert.addAction(action)
    present(alert, animated: true, completion: nil)

}

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        shoppingItems = shoppingItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
        print("search success")
        tableView.reloadData()
    }
       
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
    
    
    
    
    func loadItems()  {
        shoppingItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
     override func updateModel(at indexPath: IndexPath) {
            if let item = shoppingItems?[indexPath.row] {
                do {
                    try realm.write{
                        realm.delete(item)
                    }
                } catch {
                    print("Error deleting item, \(error)")
                }
            }
        }
    }

    

