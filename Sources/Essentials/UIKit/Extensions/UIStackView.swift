//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 22/3/21.
//

#if canImport(UIKit)
import UIKit

public extension UIStackView {

    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach { removeViewAndConstraints($0) }
    }

    func replaceArrangedSubviewsWith(_ views: [UIView]) {
        removeAllArrangedSubviews()
        views.forEach { addArrangedSubview($0) }
    }

    private func removeViewAndConstraints(_ view: UIView) {
        removeArrangedSubview(view)
        NSLayoutConstraint.deactivate(view.constraints)
        view.removeFromSuperview()
    }

}
#endif
