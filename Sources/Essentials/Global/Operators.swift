//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 7/2/21.
//

import Foundation

// MARK: - Keypaths & Higher order functions

// This will allow: `something.map(^\.description)` for example
prefix operator ^
prefix func ^ <Element, Attribute>(_ keyPath: KeyPath<Element, Attribute>) -> (Element) -> Attribute {
    return { element in element[keyPath: keyPath] }
}
