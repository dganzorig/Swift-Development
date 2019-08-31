//
//  AFile.swift
//  SwiftAccessLevels
//
//  Created by Angela Yu on 14/09/2018.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import Foundation

class AClass {
    
    //Global variables, also called class properties.
    private var aPrivateProperty = "private property"
    
    fileprivate var aFilePrivateProperty = "fileprivate property"
    
    var anInternalProperty = "internal property"
    
    func methodA () {
        
        var aLocalVariable = "local variable"
        
        //Step 1. Try to print aLocalVariable Here - Possible
        // print("\(aLocalVariable) printed from methodA in AClass")
        
        //Step 3. Try to print aPrivateProperty Here
        // print("\(self.aPrivateProperty) printed from methodA in AClass")
        
        //Step 6. Try to print aFilePrivateProperty Here
        // print("\(aFilePrivateProperty) printed from methodA in AClass")
        
        //Step 9. Try to print anInternalProperty Here
        // print("\(self.anInternalProperty) printed from methodA in AClass")
    }
    
    func methodB () {
        
        //Step 2. Try to print aLocalVariable Here
        // print("Not possible.")
        
        //Step 4. Try to print aPrivateProperty Here
        // print("\(self.aPrivateProperty) printed from methodB in AClass")
    }
    
}

class AnotherClassInTheSameFile {
    
    init() {
        
        //Step 5. Try to print aPrivateProperty Here
        // print("Not possible.")
        
        //Step 7. Try to print aFilePrivateProperty Here
        // let a = AClass()
        // print("\(a.aFilePrivateProperty) printed from init() in AClass")
    }
}
