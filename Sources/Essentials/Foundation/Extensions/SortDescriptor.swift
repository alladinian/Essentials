//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 7/2/21.
//

import Foundation

public extension String {

    func ascending() -> NSSortDescriptor {
        NSSortDescriptor.ascendingFor(self)
    }

}

public extension NSSortDescriptor {

    static func ascendingFor(_ key: String) -> NSSortDescriptor {
        NSSortDescriptor(key: key, ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
    }

}
