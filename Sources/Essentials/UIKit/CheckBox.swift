//
//  CheckBox.swift
//  
//
//  Created by Vasilis Akoinoglou on 3/2/21.
//

#if canImport(UIKit)

import UIKit

public class CheckBox: UIButton {

    public convenience init(onImage: UIImage, offImage: UIImage, action: ((Bool) -> Void)? = nil) {
        self.init(type: .custom)
        translatesAutoresizingMaskIntoConstraints = false
        setImage(onImage, for: .selected)
        setImage(offImage, for: .normal)
        onChange = action
        addTarget(self, action: #selector(toggle), for: .touchUpInside)
        setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }

    public var onChange: ((Bool) -> Void)?

    @objc func toggle() {
        isSelected.toggle()
        onChange?(isSelected)
    }
}

#endif