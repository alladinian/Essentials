//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 8/2/21.
//

#if canImport(UIKit)
import UIKit
public typealias EssentialView = UIView
#elseif canImport(AppKit)
import AppKit
public typealias EssentialView = NSView
#endif

public extension EssentialView {

    class func fromNib(_ name: String? = nil) -> Self {
        return fromNib(name, type: self)
    }

    class func fromNib<T: EssentialView>(_ name: String? = nil, type: T.Type) -> T {
        return fromNib(name, type: T.self)!
    }

    class func fromNib<T: EssentialView>(_ name: String? = nil, type: T.Type) -> T? {
        // Most nibs are demangled by practice, if not, just declare string explicitly
        let name = name ?? nibName

        #if os(iOS)
        return Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.filter({ $0 is T }).last as? T
        #elseif os(macOS)
        var views: NSArray?
        Bundle.main.loadNibNamed(name, owner: nil, topLevelObjects: &views)
        return views?.filter { $0 is T }.last as? T
        #endif
    }

    class var nibName: String {
        return "\(self)".components(separatedBy: ".").first ?? ""
    }

}
