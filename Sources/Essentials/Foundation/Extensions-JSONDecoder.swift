//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 18/1/21.
//

import Foundation

public enum JSONSerializationError: Error {
    case invalidJSONString
    case invalidJSONObject
}

public extension JSONDecoder {

    func decode<T>(_ type: T.Type, from dict: [AnyHashable : Any], keyPath: String) throws -> T where T : Decodable {
        let dict = dict as NSDictionary
        guard let object = dict.value(forKeyPath: keyPath) as? AnyHashable else {
            throw JSONSerializationError.invalidJSONObject
        }
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            throw JSONSerializationError.invalidJSONObject
        }
        return try decode(type, from: data)
    }

    func decode<T>(_ type: T.Type, from dict: [AnyHashable : Any]) throws -> T where T : Decodable {
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []) else {
            throw JSONSerializationError.invalidJSONObject
        }
        return try decode(type, from: data)
    }

    func decode<T>(_ type: T.Type, from string: String) throws -> T where T : Decodable {
        guard let data = string.data(using: .utf8) else {
            throw JSONSerializationError.invalidJSONString
        }
        return try decode(type, from: data)
    }

}
