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
        guard let identifier = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as CFString, nil) else { return false }
        return UTTypeConformsTo((identifier.takeRetainedValue()), kUTTypeImage)
    }

}

public extension URL {
    func thumbnailImage(size: NSSize) -> NSImage? {
        guard self.isImage else { return nil }
        guard let imageSource = CGImageSourceCreateWithURL(self as CFURL, nil) else { return nil }
        let options = [
            kCGImageSourceThumbnailMaxPixelSize: max(size.width, size.height),
            kCGImageSourceCreateThumbnailFromImageAlways: true // Cache the image
        ] as [CFString : Any]
        guard let scaledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options as CFDictionary) else { return nil }
        return NSImage(cgImage: scaledImage, size: .zero) // .zero here means use image's size
    }
}
#endif
