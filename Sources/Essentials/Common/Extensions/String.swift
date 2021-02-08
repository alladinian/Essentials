//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 18/1/21.
//

import Foundation

//MARK: - Optionality

public extension Optional where Wrapped == String {

    /// Checks whether a string is nil or empty
    var isNullOrEmpty: Bool {
        guard let string = self else { return true }
        return string.isEmpty
    }

    /// Returns the value of the string, or a fallback if the value is nil or empty
    /// - Parameter replacement: The replacement value
    /// - Returns: The original or replaced string
    func or(_ replacement: String) -> String {
        guard let string = self else { return replacement }
        return isNullOrEmpty ? replacement : string
    }

}

//MARK: - Matching

public extension String {

    /// Checks whether a string contains some characters
    /// - Parameter text: The text whose characters to check for
    /// - Returns: Whether `text`'s characters are contained in the string
    func doesNotContain(_ text: String) -> Bool {
        let charset = CharacterSet(charactersIn: text)
        return self.rangeOfCharacter(from: charset) == nil
    }

    /// Checks whether a string contains some text
    var containsText: Bool {
        !trimmed.isEmpty
    }

    var isNotEmpty: Bool {
        containsText
    }

}

//MARK: - Formatting

public extension String {

    /// Trims white spaces & new lines
    /// - Returns: The trimmed version of the string
    var trimmed: String {
        trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    func capitalizingFirstLetter(locale: Locale = Locale.current) -> String {
        prefix(1).capitalized(with: locale) + dropFirst()
    }

    /// Lowers the first letter of the string
    /// e.g. "People picker" gives "people picker", "Sports Stats" gives "sports Stats"
    func lowercasingFirstLetter(locale: Locale = Locale.current) -> String {
        prefix(1).lowercased(with: locale) + dropFirst()
    }

    /// If the string starts with only one uppercase letter, lowercase that first letter
    /// If the string starts with multiple uppercase letters, lowercase those first letters
    /// up to the one before the last uppercase one, but only if the last one is followed by
    /// a lowercase character.
    /// e.g. "PeoplePicker" gives "peoplePicker" but "URLChooser" gives "urlChooser"
    var loweringFirstWord: String {
        guard !isEmpty else { return "" }
        let characterSet = CharacterSet.uppercaseLetters
        let scalars      = unicodeScalars
        let start        = scalars.startIndex
        var idx          = start
        while idx < scalars.endIndex, let scalar = UnicodeScalar(scalars[idx].value), characterSet.contains(scalar) {
            idx = scalars.index(after: idx)
        }
        if idx > scalars.index(after: start) && idx < scalars.endIndex,
           let scalar = UnicodeScalar(scalars[idx].value),
           CharacterSet.lowercaseLetters.contains(scalar) {
            idx = scalars.index(before: idx)
        }
        let transformed = String(scalars[start..<idx]).lowercased() + String(scalars[idx..<scalars.endIndex])
        return transformed
    }

    // Greek transliterated version of a latin string
    var transliterated: String {
        let mutable = NSMutableString(string: self) as CFMutableString
        CFStringTransform(mutable, nil, kCFStringTransformLatinGreek, false)
        CFStringTransform(mutable, nil, kCFStringTransformStripCombiningMarks, false)
        return mutable as String
    }

    /// This returns the snake cased variant of the string.
    ///
    /// - Parameter string: The string to snake_case
    /// - Returns: The string snake cased from either snake_cased or camelCased string.
    var snakeCased: String {
        guard let longUpper = try? NSRegularExpression(pattern: "([A-Z\\d]+)([A-Z][a-z])", options: .dotMatchesLineSeparators),
              let camelCased = try? NSRegularExpression(pattern: "([a-z\\d])([A-Z])", options: .dotMatchesLineSeparators)
        else {
            return self
        }

        let fullRange = NSRange(location: 0, length: unicodeScalars.count)
        var result = longUpper.stringByReplacingMatches(
            in: self,
            options: .reportCompletion,
            range: fullRange,
            withTemplate: "$1_$2"
        )
        result = camelCased.stringByReplacingMatches(
            in: result,
            options: .reportCompletion,
            range: fullRange,
            withTemplate: "$1_$2"
        )
        return result.replacingOccurrences(of: "-", with: "_")
    }

}

//MARK: - Conversion

public extension String {

    /// The decimal value of the string (if applicable)
    var decimalValue: Decimal? {
        Decimal(string: self)
    }

    /// Encode a String to Base64
    /// - Returns: The string in Base64
    func toBase64() -> String {
        let input = self
        let data = input.data(using: String.Encoding.utf8)
        return data!.base64EncodedString(options: .lineLength64Characters)
    }

}

//MARK: - Validation

// See: http://emailregex.com && https://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
fileprivate let emailRegEx = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" +
    "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
    "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" +
    "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" +
    "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
    "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
    "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"

fileprivate let phoneRegEx = "^\\+?\\d+$"

public extension String {

    var isValidEmail: Bool {
        let emailTest  = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }

    var isValidPhone: Bool {
        let mobileTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return mobileTest.evaluate(with: self)
    }

}
