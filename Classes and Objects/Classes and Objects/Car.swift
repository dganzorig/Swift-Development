//
//  Car.swift
//  Classes and Objects
//
//  Created by Dona Ganzorig on 8/11/19.
//  Copyright © 2019 Dona Ganzorig. All rights reserved.
//

import Foundation

enum CarType {
    case Sedan
    case Coupe
    case Hatchback
}

class Car {
    
    var color: String = "Black"
    var numberOfSeats: Int = 5
    var typeOfCar: CarType = .Coupe // enumeration
    
    init() {
        
    }
    
    convenience init(customerChosenColor: String) {
        self.init()
        self.color = customerChosenColor
    }
    
    func drive() {
        print("Car is moving")
    }
    
}
