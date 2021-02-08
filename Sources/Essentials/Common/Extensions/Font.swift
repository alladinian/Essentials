//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 8/2/21.
//

import Foundation

public extension EssentialFont {
    var path: String? {
        let fontRef  = CTFontDescriptorCreateWithNameAndSize(fontName as CFString, pointSize)
        let url      = CTFontDescriptorCopyAttribute(fontRef, kCTFontURLAttribute)
        let fontPath = (url as! NSURL).path
        return fontPath
    }
}
