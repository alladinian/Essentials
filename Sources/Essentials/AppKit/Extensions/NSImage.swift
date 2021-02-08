//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 8/2/21.
//

#if canImport(AppKit)

import AppKit

public extension NSImage {
    func image(with tintColor: NSColor) -> NSImage {
        guard let image = self.copy() as? NSImage else { return self }
        image.lockFocus()
        tintColor.set()
        let imageRect = NSRect(origin: .zero, size: image.size)
        imageRect.fill(using: .sourceIn)
        image.unlockFocus()
        image.isTemplate = false
        return image
    }
}

#endif
