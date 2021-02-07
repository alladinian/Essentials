//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 18/1/21.
//

import Foundation

//MARK: - Conversion

extension Collection {

    func toJSONString() -> String? {
        guard let json = try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted]) else { return nil }
        return String(data: json, encoding: .utf8)
    }

}

//MARK: - String Collections

public extension Collection where Element == String {

    var commaSeparated: String {
        filter { $0.isEmpty == false }.joined(separator: ", ")
    }

}

extension Collection where Element == String? {

    var commaSeparated: String {
        compactMap { $0 }.commaSeparated
    }

}

public extension Collection where Element: StringProtocol {

    func localizedStandardSorted(_ result: ComparisonResult) -> [Element] {
        sorted { $0.localizedStandardCompare($1) == result }
    }

}

//MARK: - Optionality

public extension Optional where Wrapped: Collection {

    var orEmpty: [Wrapped.Iterator.Element] {
        guard let collection = self as? [Wrapped.Iterator.Element] else {
            return []
        }
        return collection
    }

}

//MARK: - Access

extension BidirectionalCollection where Iterator.Element: Equatable {

    typealias Element = Self.Iterator.Element

    func after(_ item: Element, loop: Bool = false) -> Element? {
        if let itemIndex = self.firstIndex(of: item) {
            let lastItem: Bool = (index(after:itemIndex) == endIndex)
            if loop && lastItem {
                return self.first
            } else if lastItem {
                return nil
            } else {
                return self[index(after:itemIndex)]
            }
        }
        return nil
    }

    func before(_ item: Element, loop: Bool = false) -> Element? {
        if let itemIndex = self.firstIndex(of: item) {
            let firstItem: Bool = (itemIndex == startIndex)
            if loop && firstItem {
                return self.last
            } else if firstItem {
                return nil
            } else {
                return self[index(before:itemIndex)]
            }
        }
        return nil
    }

}
