#if canImport(UIKit)

import UIKit
public typealias EssentialFont  = UIFont
public typealias EssentialColor = UIColor

#elseif canImport(AppKit)

import AppKit
public typealias EssentialFont  = NSFont
public typealias EssentialColor = NSColor

#endif
