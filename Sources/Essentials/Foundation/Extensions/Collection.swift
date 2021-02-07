//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 18/1/21.
//

import Foundation

//MARK: - Conversion

extension Collection {

    func toJSONString(pretty: Bool = true) -> String? {
        let options: JSONSerialization.WritingOptions = pretty ? [.prettyPrinted] : []
        guard let json = try? JSONSerialization.data(withJSONObject: self, options: options) else { return nil }
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

    func after(_ item: Element, cycle: Bool = false) -> Element? {
        guard let itemIndex = self.firstIndex(of: item) else {
            return nil
        }

        let lastItem: Bool = (index(after:itemIndex) == endIndex)

        if cycle && lastItem {
            return self.first
        } else if lastItem {
            return nil
        }

        return self[index(after:itemIndex)]
    }

    func before(_ item: Element, cycle: Bool = false) -> Element? {
        guard let itemIndex = self.firstIndex(of: item) else {
            return nil
        }

        let firstItem: Bool = (itemIndex == startIndex)

        if cycle && firstItem {
            return self.last
        } else if firstItem {
            return nil
        }

        return self[index(before:itemIndex)]
    }

}
