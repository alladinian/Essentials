//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 18/1/21.
//

#if canImport(UIKit)
import UIKit

//MARK: - Layout

public extension UIView {

    var systemLayoutSize: CGSize {
        systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }

    func pinEdges(to other: UIView) {
        translatesAutoresizingMaskIntoConstraints                         = false
        leadingAnchor.constraint(equalTo: other.leadingAnchor).isActive   = true
        trailingAnchor.constraint(equalTo: other.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: other.topAnchor).isActive           = true
        bottomAnchor.constraint(equalTo: other.bottomAnchor).isActive     = true
    }

    func fillContainer() {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview(view:)` before calling `fillContainer()` to fix this.")
            return
        }
        pinEdges(to: superview)
    }

    @discardableResult
    func huggingPriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) -> Self {
        setContentHuggingPriority(priority, for: axis)
        return self
    }

    @discardableResult
    func compressionResistance(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) -> Self {
        setContentCompressionResistancePriority(priority, for: axis)
        return self
    }

}

//MARK: - Styling

public extension UIView {

    convenience init(color: UIColor) {
        self.init()
        backgroundColor = color
    }

    @available(iOS 11.0, *)
    func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
       layer.cornerRadius  = radius
       layer.maskedCorners = corners
    }

}

//MARK: - Animations

public extension UIView {

    func fadeTransition(duration: CFTimeInterval) {
        let animation: CATransition = CATransition()
        animation.timingFunction    = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type              = CATransitionType.fade
        animation.duration          = duration
        layer.add(animation, forKey: "Fade")
    }

    func animateLayout() {
        UIView.animate(withDuration: 0.45, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.allowUserInteraction]) { [weak self] in
            self?.layoutIfNeeded()
        }
    }

}

#endif
