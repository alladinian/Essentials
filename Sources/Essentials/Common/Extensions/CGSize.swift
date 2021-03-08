//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 8/3/21.
//

import Foundation

/// Addition operator for CGSize structs
/// - Parameters:
///   - lhs: The first CGSize
///   - rhs: The second CGSize
/// - Returns: A new size after adding the two sizes
public func +(lhs: CGSize, rhs: CGSize) -> CGSize {
    CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}
