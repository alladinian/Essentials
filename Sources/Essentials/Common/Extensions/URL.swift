//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 13/3/21.
//

import Foundation

@available(OSX 10.13, iOS 11.0, *)
public extension URL {
    var asURLItemProvider: NSItemProvider {
        NSItemProvider(object: self as NSURL)
    }
}

extension URL: ExpressibleByStringLiteral {
    // By using 'StaticString' we disable string interpolation, for safety
    public init(stringLiteral value: StaticString) {
        self = URL(string: "\(value)")!
    }
}

#if canImport(AppKit)
import AppKit

public extension URL {
    var isImage: Bool {
        guard let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as CFString, nil) else { return false }
        return UTTypeConformsTo((uti.takeRetainedValue()), kUTTypeImage)
    }

}
#endif
