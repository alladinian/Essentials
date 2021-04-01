//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 8/3/21.
//

import Foundation
import CoreGraphics

/// Addition support for CGSize
public func +(lhs: CGSize, rhs: CGSize) -> CGSize {
    CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}

/// Subtraction support for CGSize
public func -(lhs: CGSize, rhs: CGSize) -> CGSize {
    CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
}

public extension CGSize {
    init(_ width: CGFloat, _ height: CGFloat) {
        self.init(width: width, height: height)
    }
}
