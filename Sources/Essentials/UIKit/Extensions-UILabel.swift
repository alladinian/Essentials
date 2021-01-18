//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 18/1/21.
//

#if canImport(UIKit)
import UIKit

//MARK: - Initialization

public extension UILabel {

    convenience init(_ text: String) {
        self.init(frame: .zero)
        self.text = text
    }

}

//MARK: - Helpers

extension UILabel {

    /// Wraps a label in a view
    /// Overcomes an issue with multiline labels
    /// when using auto layout
    /// - Returns: The wrapped label
    func wrappedInView() -> UIView {
        let view = UIView()
        view.addSubview(self)
        fillContainer()
        return view
    }

}

//MARK: - Formatting

public extension UILabel {

    func setLineHeight(lineHeight: CGFloat) {
        guard let text = self.text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineHeightMultiple = lineHeight
        attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, text.count))
        self.attributedText = attributeString
    }

}

#endif
