//
//  TappableLabel.swift
//  
//
//  Created by Vasilis Akoinoglou on 3/2/21.
//

import UIKit

public class TappableLabel: UILabel {

    lazy var recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))

    public convenience init(text: String) {
        self.init()
        self.text = text
        self.isUserInteractionEnabled = true
        addGestureRecognizer(recognizer)
    }

    public var onTap: ((UILabel, UITapGestureRecognizer) -> Void)?

    @objc func didTap(_ recognizer: UITapGestureRecognizer) {
        onTap?(self, recognizer)
    }
}
