//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 18/1/21.
//

import Foundation

public extension Sequence {

    /// Simplification for `objects.compactMap { $0 as? T }`
    func castMap<T>(_ type: T.Type) -> [T] {
        compactMap { $0 as? T }
    }

}

public extension Sequence where Element: OptionalConvertible {

    /// Simplification for `objects.compactMap { $0 }`
    func compacted() -> [Element.Wrapped] {
        compactMap { $0.asOptional() }
    }

}
