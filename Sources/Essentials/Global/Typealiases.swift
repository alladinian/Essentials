#if canImport(UIKit)

import UIKit
public typealias EssentialFont  = UIFont
public typealias EssentialColor = UIColor
public typealias EssentialView  = UIView

#elseif canImport(AppKit)

import AppKit
public typealias EssentialFont  = NSFont
public typealias EssentialColor = NSColor
public typealias EssentialView  = NSView

#endif
