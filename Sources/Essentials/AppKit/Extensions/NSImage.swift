//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 8/2/21.
//

#if os(macOS)

import AppKit

public extension NSImage {

    /// Produce a copy of the image after tinting
    /// - Parameter color: The tint color
    /// - Returns: A new tinted image
    func withTintColor(_ color: NSColor) -> NSImage {
        guard let image = self.copy() as? NSImage else { return self }
        image.lockFocus()
        color.set()
        let imageRect = NSRect(origin: .zero, size: image.size)
        imageRect.fill(using: .sourceIn)
        image.unlockFocus()
        image.isTemplate = false
        return image
    }

    /// The image as CGImage
    @objc var cgImage: CGImage? {
        get {
            guard let imageData = self.tiffRepresentation else { return nil }
            guard let sourceData = CGImageSourceCreateWithData(imageData as CFData, nil) else { return nil }
            return CGImageSourceCreateImageAtIndex(sourceData, 0, nil)
        }
    }

}

#endif
