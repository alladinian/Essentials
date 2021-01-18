//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 18/1/21.
//

import Foundation

public extension Sequence {

    /// Simplification for `objects.compactMap { $0 as? CastType }`
    func castMap<CastType>(_ type: CastType.Type) -> [CastType] {
        compactMap { $0 as? CastType }
    }

}

public extension Sequence where Element: OptionalConvertible {

    /// Simplification for `objects.compactMap { $0 }`
    func compacted() -> [Element.Wrapped] {
        compactMap { $0.asOptional() }
    }

}
