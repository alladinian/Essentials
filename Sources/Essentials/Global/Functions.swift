//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 7/2/21.
//

import Foundation

public func print(_ error: Error) {
    debugPrint(error.localizedDescription)
}

public func onMain(_ block: @escaping () -> Void) {
    DispatchQueue.main.async(execute: block)
}
