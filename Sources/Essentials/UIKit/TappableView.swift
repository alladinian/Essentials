//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 3/2/21.
//

import UIKit

public class TappableView: UIView {
    public convenience init(width: CGFloat? = nil, height: CGFloat? = nil, onTap: (() -> Void)? = nil) {
        self.init()
        self.onTap = onTap
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        addGestureRecognizer(tap)
    }

    public var onTap: (() -> Void)?

    @objc func tapAction() {
        onTap?()
    }
}
