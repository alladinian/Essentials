//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 8/2/21.
//

import Foundation

#if os(macOS)
import AppKit

public extension EssentialFont {
    var path: String? {
        let fontRef  = CTFontDescriptorCreateWithNameAndSize(fontName as CFString, pointSize)
        let url      = CTFontDescriptorCopyAttribute(fontRef, kCTFontURLAttribute)
        let fontPath = (url as! NSURL).path
        return fontPath
    }

    var faceName: String {
        let family   = familyName ?? ""
        let fullName = displayName ?? ""
        return fullName.replacingOccurrences(of: family, with: "").trimmed
    }
}

#endif
