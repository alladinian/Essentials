#if canImport(UIKit)

import UIKit
public typealias EssentialFont  = UIFont
public typealias EssentialColor = UIColor
public typealias EssentialView  = UIView
public typealias EssentialImage = UIImage

#elseif canImport(AppKit)

import AppKit
public typealias EssentialFont  = NSFont
public typealias EssentialColor = NSColor
public typealias EssentialView  = NSView
public typealias EssentialImage = NSImage

#endif

public typealias Radians = CGFloat

public let π = CGFloat.pi

import CoreGraphics

public extension EssentialColor {
    #if os(macOS)
    convenience init(h: CGFloat = 1.0, s: CGFloat = 1.0, b: CGFloat = 1.0, a: CGFloat = 1.0, colorSpace cgColorSpace: CGColorSpace? = nil) {
        if let cgColorSpace, let colorSpace = NSColorSpace(cgColorSpace: cgColorSpace) {
            self.init(colorSpace: colorSpace, hue: h, saturation: s, brightness: b, alpha: a)
        } else {
            self.init(hue: h, saturation: s, brightness: b, alpha: a)
        }
    }
    #else
    convenience init(h: CGFloat = 1.0, s: CGFloat = 1.0, b: CGFloat = 1.0, a: CGFloat = 1.0, colorSpace: CGColorSpace? = nil) {
        self.init(hue: h, saturation: s, brightness: b, alpha: a)
    }
    #endif
}
