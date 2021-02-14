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

public func onBackground(qos: DispatchQoS.QoSClass = .default, _ block: @escaping () -> Void) {
    DispatchQueue.global(qos: qos).async(execute: block)
}
