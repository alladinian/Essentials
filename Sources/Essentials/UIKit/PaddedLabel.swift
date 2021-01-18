//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 18/1/21.
//

#if canImport(UIKit)
import UIKit

public class PaddedLabel: UILabel {

    public var padding: UIEdgeInsets? = nil

    public override func drawText(in rect: CGRect) {
        guard let padding = padding else {
            super.drawText(in: rect)
            return
        }
        super.drawText(in: rect.inset(by: padding))
    }

}

#endif
