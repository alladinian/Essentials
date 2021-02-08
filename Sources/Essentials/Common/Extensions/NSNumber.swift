//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 8/2/21.
//

import Foundation

public extension NSNumber {
    var isBool: Bool {
        let boolID = CFBooleanGetTypeID() // the type ID of CFBoolean
        let numID  = CFGetTypeID(self) // the type ID of num
        return numID == boolID
    }
}
