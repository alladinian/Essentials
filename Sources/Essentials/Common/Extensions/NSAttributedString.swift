//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 18/1/21.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

@available(macOS 10.11, *)
public extension String {

    func regular(size: CGFloat = EssentialFont.systemFontSize) -> NSAttributedString {
        NSAttributedString(string: self, attributes: [.font: EssentialFont.systemFont(ofSize: size, weight: .regular)])
    }

    func semibold(size: CGFloat = EssentialFont.systemFontSize) -> NSAttributedString {
        NSAttributedString(string: self, attributes: [.font: EssentialFont.systemFont(ofSize: size, weight: .semibold)])
    }

    func bold(font: EssentialFont? = nil, size: CGFloat = EssentialFont.systemFontSize) -> NSAttributedString {
        NSAttributedString(string: self, attributes: [.font: EssentialFont.systemFont(ofSize: size, weight: .bold)])
    }

}

public extension String {
    var attributed: NSMutableAttributedString {
        NSMutableAttributedString(string: self)
    }
}

public extension NSAttributedString {

    /// Returns a colored attributed string
    func colored(color: EssentialColor) -> NSMutableAttributedString {
        let string = NSMutableAttributedString(attributedString: self)
        string.addAttributes([.foregroundColor: color], range: NSRange(location: 0, length: length))
        return string
    }

}

public extension NSMutableAttributedString {

    // Set the linespacing
    func lineSpacing(_ spacing: CGFloat) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: length)
        )
        return self
    }

}

// Operator support for attributed strings
infix operator +  : AdditionPrecedence
infix operator +-+ : AdditionPrecedence

public func + (left: NSAttributedString, right: NSAttributedString) -> NSMutableAttributedString {
    let string = NSMutableAttributedString(attributedString: left)
    string.append(right)
    return string
}

public func + (left: String, right: NSAttributedString) -> NSMutableAttributedString {
    return left.attributed + right
}

public func + (left: NSAttributedString, right: String) -> NSMutableAttributedString {
    return left + right.attributed
}

public func + (left: NSMutableAttributedString, right: String) -> NSMutableAttributedString {
    return NSAttributedString(attributedString: left) + right.attributed
}

public func +-+ (left: NSAttributedString, right: NSAttributedString) -> NSMutableAttributedString {
    return left + " " + right
}

