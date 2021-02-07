//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 18/1/21.
//

import Foundation

public extension Bundle {

    var releaseVersionNumber: String? {
        infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var buildVersionNumber: String? {
        infoDictionary?["CFBundleVersion"] as? String
    }

    var composedVersionString: String {
        [releaseVersionNumber, buildVersionNumber].commaSeparated
    }

}
