//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 13/3/21.
//

import Foundation

public extension NSDecimalNumber {
    convenience init?(possibleNumber data: Any?) {
        if let number = data as? NSNumber {
            self.init(value: number.doubleValue)
        } else if let string = data as? String {
            self.init(string: string)
        } else {
            return nil
        }
    }
}
