//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 8/2/21.
//

import Foundation

public extension KeyPath where Root: NSObject {
    var stringValue: String {
        NSExpression(forKeyPath: self).keyPath
    }
}
