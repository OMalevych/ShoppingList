//
//  Category.swift
//  shoppingList
//
//  Created by Oksana Malevich on 01.09.2020.
//  Copyright © 2020 Oksana Malevich. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>() 
}
