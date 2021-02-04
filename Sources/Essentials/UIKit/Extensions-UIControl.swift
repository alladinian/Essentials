//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 4/2/21.
//

import UIKit

@objc class ClosureSleeve: NSObject {
    let closure: ()->()

    init (_ closure: @escaping ()->()) {
        self.closure = closure
    }

    @objc func invoke() {
        closure()
    }
}

public extension UIControl {

    struct ControlAssociatedKeys {
        static var sleeveKey: UInt8 = 0
    }

    @discardableResult
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping ()->()) -> Self {
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, &ControlAssociatedKeys.sleeveKey, sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        return self
    }
}
