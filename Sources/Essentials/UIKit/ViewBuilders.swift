//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 18/1/21.
//

#if canImport(UIKit)
import UIKit

protocol ViewProvider {
    var body: UIView { get }
}

extension UIView: ViewProvider {
    var body: UIView { self }
}

@_functionBuilder
struct SubviewBuilder {

    typealias ViewList = [UIView]

    static func buildBlock(_ subviews: UIView...) -> ViewList {
        subviews
    }

    static func buildBlock(_ subviews: ViewList) -> ViewList {
        subviews
    }

}

extension SubviewBuilder {

    static func buildEither(first: UIView) -> UIView {
        first
    }

    static func buildEither(second: UIView) -> UIView {
        second
    }
}


// MARK: - UIView
protocol With {}

extension With where Self: AnyObject {
    // Note: The Swift compiler does not perform OS availability checks on properties referenced by keypaths
    @discardableResult
    func with<T>(_ property: ReferenceWritableKeyPath<Self, T>, setTo value: T) -> Self {
        self[keyPath: property] = value
        return self
    }
}

extension UIView: With {}

//MARK: - View
public func View(@SubviewBuilder _ content: () -> [UIView]) -> UIView {
    let view = UIView()
    for subview in content() {
        view.addSubview(subview)
    }
    return view
}

// MARK: - StackView
public func HStackView(alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill, spacing: CGFloat = 0, @SubviewBuilder _ content: () -> [UIView]) -> UIStackView {
    let stack          = UIStackView(arrangedSubviews: [])
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.alignment    = alignment
    stack.distribution = distribution
    stack.spacing      = spacing
    stack.axis         = .horizontal
    content().forEach { stack.addArrangedSubview($0) }
    return stack
}

public func VStackView(alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill, spacing: CGFloat = 0, @SubviewBuilder _ content: () -> [UIView]) -> UIStackView {
    let stack          = UIStackView(arrangedSubviews: [])
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.alignment    = alignment
    stack.distribution = distribution
    stack.spacing      = spacing
    stack.axis         = .vertical
    content().forEach { stack.addArrangedSubview($0) }
    return stack
}

#endif
