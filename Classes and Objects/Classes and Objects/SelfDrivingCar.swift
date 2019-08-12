//
//  SelfDrivingCar.swift
//  Classes and Objects
//
//  Created by Dona Ganzorig on 8/12/19.
//  Copyright © 2019 Dona Ganzorig. All rights reserved.
//

import Foundation

class SelfDrivingCar: Car {
    
    var destination: String?
    
    override func drive() {
        super.drive()
        if let userSetDestination = destination {
            print("Driving towards: \(userSetDestination)")
        }
    }
    
}
