//
//  Item.swift
//  Todoey
//
//  Created by Dona Ganzorig on 8/27/19.
//  Copyright © 2019 Dona Ganzorig. All rights reserved.
//

import Foundation

// Codable classes cannot contain custom classes
// Can also do Encodable and Decodable separately
class Item: Codable {
    
    var title: String = ""
    var done: Bool = false
    
}
