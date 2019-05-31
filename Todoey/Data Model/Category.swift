//
//  Category.swift
//  Todoey
//
//  Created by Rosalie Wessels on 5/31/19.
//  Copyright © 2019 Rosalie Wessels. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
