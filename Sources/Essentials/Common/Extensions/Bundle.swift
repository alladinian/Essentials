//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 18/1/21.
//

import Foundation

public extension Bundle {

    /// The release version number of the bundle (CFBundleShortVersionString)
    var releaseVersionNumber: String? {
        infoDictionary?["CFBundleShortVersionString"] as? String
    }

    /// The build version number of the bundle (CFBundleVersion)
    var buildVersionNumber: String? {
        infoDictionary?["CFBundleVersion"] as? String
    }

    /// The version number of the bundle as "release, build"
    var composedVersionString: String {
        [releaseVersionNumber, buildVersionNumber].commaSeparated
    }

}
