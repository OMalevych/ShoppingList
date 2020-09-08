//
//  Item.swift
//  shoppingList
//
//  Created by Oksana Malevich on 01.09.2020.
//  Copyright © 2020 Oksana Malevich. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
   @objc dynamic var title : String = ""
   @objc dynamic var done : Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
