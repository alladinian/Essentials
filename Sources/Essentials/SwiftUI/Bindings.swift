//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 13/3/21.
//

#if canImport(SwiftUI) && canImport(Combine)
import SwiftUI
import Combine

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
#endif
