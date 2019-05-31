//
//  Item.swift
//  Todoey
//
//  Created by Rosalie Wessels on 5/31/19.
//  Copyright © 2019 Rosalie Wessels. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
