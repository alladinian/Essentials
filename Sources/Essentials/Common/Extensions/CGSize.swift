//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 8/3/21.
//

import Foundation
import CoreGraphics

public func +(lhs: CGSize, rhs: CGSize) -> CGSize {
    CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}

public func -(lhs: CGSize, rhs: CGSize) -> CGSize {
    CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
}
