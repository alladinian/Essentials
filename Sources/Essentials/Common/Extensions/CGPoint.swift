//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 21/4/24.
//

import Foundation
import CoreGraphics

public func + (lhs: CGPoint, rhs: CGSize) -> CGPoint {
    CGPoint(x: lhs.x + rhs.width, y: lhs.y + rhs.height)
}

public func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func + (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    CGPoint(x: lhs.x + rhs, y: lhs.y + rhs)
}

public func - (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    CGPoint(x: lhs.x - rhs, y: lhs.y - rhs)
}

public extension CGPoint {
    var asSize: CGSize { CGSize(width: x, height: y) }
}
