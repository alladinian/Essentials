//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 18/1/21.
//

import Foundation

// MARK: - Bindings

public struct Bindable<Value> {

    public var value: Value {
        didSet {
            onUpdate?(value)
        }
    }

    public var onUpdate: ((Value) -> Void)? {
        didSet {
            onUpdate?(value)
        }
    }

    public init(_ value: Value, _ onUpdate: ((Value) -> Void)? = nil) {
        self.value    = value
        self.onUpdate = onUpdate
        self.onUpdate?(value)
    }

}
