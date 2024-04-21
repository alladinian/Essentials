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

public extension CGPoint {
    var asSize: CGSize { CGSize(width: x, height: y) }
}
