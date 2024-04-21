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

// Subtraction support for CGSize - CGFloat
public func - (lhs: CGSize, rhs: CGFloat) -> CGSize {
    CGSize(width: lhs.width - rhs, height: lhs.height - rhs)
}

// Convenience properties
public extension CGSize {
    var half: CGSize { CGSize(width: width / 2, height: height / 2) }
    var center: CGPoint { CGPoint(x: half.width, y: half.height)  }
}

// Positional initializer
public extension CGSize {
    init(_ width: CGFloat, _ height: CGFloat) {
        self.init(width: width, height: height)
    }
}
