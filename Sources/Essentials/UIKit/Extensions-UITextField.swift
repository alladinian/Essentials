//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 18/1/21.
//

#if canImport(UIKit)
import UIKit

public extension UITextField {

    var containsText: Bool {
        text.or("").containsText
    }

}

#endif
