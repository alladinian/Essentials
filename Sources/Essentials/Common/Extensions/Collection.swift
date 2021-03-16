//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 18/1/21.
//

import Foundation

//MARK: - Conversion

public extension Collection {

    /// Convert a collection to a JSON string
    /// - Parameter pretty: Whether the output is pretty printed. Default is true.
    /// - Returns: The JSON representation of the collection
    func toJSONString(pretty: Bool = true) -> String? {
        let options: JSONSerialization.WritingOptions = pretty ? [.prettyPrinted] : []
        guard let json = try? JSONSerialization.data(withJSONObject: self, options: options) else { return nil }
        return String(data: json, encoding: .utf8)
    }

}

//MARK: - String Collections

public extension Collection where Element == String {

    /// The non-empty elements of the collection, comma separated
    var commaSeparated: String {
        filter { $0.isEmpty == false }.joined(separator: ", ")
    }

}

public extension Collection where Element == String? {

    /// The non-empty elements of the collection, comma separated
    var commaSeparated: String {
        compactMap { $0 }.commaSeparated
    }

}

public extension Collection where Element: StringProtocol {

    /// The elements of the collection, sorted by `localizedStandardCompare`
    /// - Parameter result: The ordering of the sorting
    /// - Returns: The elements of the collection, sorted by `localizedStandardCompare`
    func localizedStandardSorted(_ result: ComparisonResult) -> [Element] {
        sorted { $0.localizedStandardCompare($1) == result }
    }

}

//MARK: - Optionality

public extension Optional where Wrapped: Collection {

    /// The collection itself or an empty one if the optional is nil
    var orEmpty: [Wrapped.Iterator.Element] {
        (self as? [Wrapped.Iterator.Element]) ?? []
    }

}

//MARK: - Access

public extension BidirectionalCollection where Iterator.Element: Equatable {

    typealias Element = Self.Iterator.Element

    /// Access the element after a given one
    /// - Parameters:
    ///   - element: The element that precedes
    ///   - cycle: Whether collection should be treated as cyclical. Default is `false`.
    /// - Returns: The element after `element` or `nil` if `element` could not be found
    func elementAfter(_ element: Element, cycle: Bool = false) -> Element? {
        guard let elementIndex = self.firstIndex(of: element) else {
            return nil
        }

        let lastElement: Bool = (index(after:elementIndex) == endIndex)

        if cycle && lastElement {
            return self.first
        } else if lastElement {
            return nil
        }

        return self[index(after:elementIndex)]
    }

    /// Access the element before a given one
    /// - Parameters:
    ///   - element: The element that follows
    ///   - cycle: Whether collection should be treated as cyclical. Default is `false`.
    /// - Returns: The element before `element` or `nil` if `element` could not be found
    func elementBefore(_ element: Element, cycle: Bool = false) -> Element? {
        guard let elementIndex = self.firstIndex(of: element) else {
            return nil
        }

        let firstElement: Bool = (elementIndex == startIndex)

        if cycle && firstElement {
            return self.last
        } else if firstElement {
            return nil
        }

        return self[index(before:elementIndex)]
    }

}
