//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 13/3/21.
//

import Foundation
import Combine

@available(macOS 10.13, iOS 11.0, *)
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

enum ItemProviderError: Error {
    case invalidFileURLData
    case invalidFileURL
}

@available(macOS 11.0, iOS 13.0, *)
public extension Array where Element == NSItemProvider {

    // Provide a publisher for generating urls from item providers
    var urlPublisher: AnyPublisher<[URL], Error> {
        func urlForItemProvider(_ provider: NSItemProvider) -> Future<URL, Error> {
            Future { promise in
                provider.loadItem(forTypeIdentifier: UTType.fileURL.identifier, options: nil) { (data, error) in

                    guard error == nil else {
                        promise(.failure(error!))
                        return
                    }

                    guard let data = data as? Data else {
                        promise(.failure(ItemProviderError.invalidFileURLData))
                        return
                    }

                    guard let url = URL(dataRepresentation: data, relativeTo: nil) else {
                        promise(.failure(ItemProviderError.invalidFileURL))
                        return
                    }

                    return promise(.success(url))
                }
            }
        }

        return Publishers
            .MergeMany(map(urlForItemProvider))
            .collect()
            .eraseToAnyPublisher()
    }

}

#if canImport(AppKit)
import AppKit
import UniformTypeIdentifiers

public extension URL {
    var isImage: Bool {
        guard let identifier = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as CFString, nil) else { return false }
        return UTTypeConformsTo((identifier.takeRetainedValue()), kUTTypeImage)
    }

}

public extension URL {
    func thumbnailImage(size: NSSize) -> NSImage? {
        guard self.isImage else { return nil }
        let imageSourceOptions = [kCGImageSourceShouldCache : false] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithURL(self as CFURL, imageSourceOptions) else { return nil }
        let maxDimension: CGFloat = max(size.width, size.height) * (NSScreen.main?.backingScaleFactor ?? 1.0)
        let options = [
            kCGImageSourceCreateThumbnailFromImageAlways: true, // Cache the image
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform : true,
            kCGImageSourceThumbnailMaxPixelSize : maxDimension,
            //kCGImageSourceCreateThumbnailFromImageIfAbsent : true,
        ] as CFDictionary
        guard let scaledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options as CFDictionary) else { return nil }
        return NSImage(cgImage: scaledImage, size: .zero) // .zero here means use image's size
    }
}
#endif
