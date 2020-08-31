//
//  ViewController.swift
//  shoppingList
//
//  Created by Oksana Malevich on 30.08.2020.
//  Copyright © 2020 Oksana Malevich. All rights reserved.
//

import UIKit

class ShoppingListViewController: UITableViewController {

    
    
   
    
    var itemArray = ["one", "two", "three"]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
      
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
         {
          let cell = self.tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
           
            cell.textLabel?.text = itemArray[indexPath.row]
            

            

           return cell
       }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        
        tableView.deselectRow(at: indexPath, animated: true)

       
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }

    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
   
    

}

