//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 3/2/21.
//

import Foundation

@propertyWrapper
public struct UserDefault<T> {
    let key: String
    let defaultValue: T?

    public init(_ key: String, defaultValue: T? = nil) {
        self.key = key
        self.defaultValue = defaultValue
        if let value = defaultValue {
            UserDefaults.standard.register(defaults: [key: value])
        }
    }

    public var wrappedValue: T? {
        get { UserDefaults.standard.object(forKey: key) as? T ?? defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
}

@propertyWrapper
struct Trimmed {
    private(set) var value: String = ""

    var wrappedValue: String {
        get { value }
        set { value = newValue.trimmed }
    }

    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}
