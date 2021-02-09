//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 8/2/21.
//

import Foundation

#if canImport(AppKit)
import AppKit

public extension EssentialFont {
    var path: String? {
        let fontRef  = CTFontDescriptorCreateWithNameAndSize(fontName as CFString, pointSize)
        let url      = CTFontDescriptorCopyAttribute(fontRef, kCTFontURLAttribute)
        let fontPath = (url as! NSURL).path
        return fontPath
    }
}

#endif
