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
        leadingAnchor.constraint(equalTo: other.leadingAnchor).isActive   = true
        trailingAnchor.constraint(equalTo: other.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: other.topAnchor).isActive           = true
        bottomAnchor.constraint(equalTo: other.bottomAnchor).isActive     = true
    }

    func fillContainer() {
        guard let superview = superview else { return }
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

//MARK: - Nibs

public extension UIView {

    class func fromNib(_ name: String? = nil) -> Self {
        return fromNib(name, type: self)
    }

    class func fromNib<T: UIView>(_ name: String? = nil, type: T.Type) -> T {
        return fromNib(name, type: T.self)!
    }

    class func fromNib<T: UIView>(_ name: String? = nil, type: T.Type) -> T? {
        // Most nibs are demangled by practice, if not, just declare string explicitly
        let name = name ?? nibName
        let nibViews = Foundation.Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        return nibViews?.filter({ $0 is T }).last as? T
    }

    class var nibName: String {
        return "\(self)".components(separatedBy: ".").first ?? ""
    }

}

#endif
