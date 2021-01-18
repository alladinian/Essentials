//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 18/1/21.
//

import Foundation

public func print(_ error: Error) {
    debugPrint(error.localizedDescription)
}

public func onMain(_ block: @escaping () -> Void) {
    DispatchQueue.main.async(execute: block)
}

// MARK: - Keypaths & Higher order functions

// This will allow: `something.map(^\.description)` for example
prefix operator ^
prefix func ^ <Element, Attribute>(_ keyPath: KeyPath<Element, Attribute>) -> (Element) -> Attribute {
    return { element in element[keyPath: keyPath] }
}
