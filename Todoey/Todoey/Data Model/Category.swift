//
//  Category.swift
//  Todoey
//
//  Created by Dona Ganzorig on 8/30/19.
//  Copyright © 2019 Dona Ganzorig. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var backgroundColor: String = ""
    let items = List<Item>()
    
}
