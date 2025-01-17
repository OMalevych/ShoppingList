//
//  SwipeTableViewController.swift
//  shoppingList
//
//  Created by Oksana Malevich on 02.10.2020.
//  Copyright © 2020 Oksana Malevich. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
    
            cell.delegate = self
            return cell
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
           guard orientation == .right else { return nil }

           let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
               print("Delete Cell")
            self.updateModel(at: indexPath)
            
           }

           deleteAction.image = UIImage(named: "delete")

           return [deleteAction]
       }
       
       func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
           var options = SwipeOptions()
           options.expansionStyle = .destructive
           return options
       }
   
    
    func updateModel(at indexPath: IndexPath) {
    }
    
}
