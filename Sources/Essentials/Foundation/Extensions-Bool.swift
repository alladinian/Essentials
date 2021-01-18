//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 18/1/21.
//

import Foundation

public extension Bool {

    /// Returns the textual version of the Bool's value `(true|false)`
    var asString: String {
        self ? "true" : "false"
    }

    /// Returns the numerical version of the Bool's value (useful for use with alpha values)
    var asInt: Int {
        self ? 1 : 0
    }

}
