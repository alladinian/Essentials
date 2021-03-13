//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 13/3/21.
//

import Foundation

/*----------------------------------------------------------------------------*/

func ==(a: ESLogLevel, b: ESLogLevel) -> Bool { return a.rawValue == b.rawValue }
func <(a: ESLogLevel, b: ESLogLevel) -> Bool { return a.rawValue < b.rawValue }

/*----------------------------------------------------------------------------*/

enum ESLogLevel: Int, Comparable {
    case none = 0
    case error
    case warning
    case success
    case info
    case timer
    case appEvent
    case custom

    var symbol: String {
        switch self {
        case .none:     return ""
        case .error:    return "⛔️"
        case .warning:  return "⚠️"
        case .success:  return "✅"
        case .info:     return "📬"
        case .timer:    return "⏲"
        case .appEvent: return "📱"
        case .custom:   return "✏️"
        }
    }
}

/*----------------------------------------------------------------------------*/

class ESLogger {
    static var verbosityLevel: ESLogLevel = .custom
    static var iconsEnabled = true
}

func ESLog(_ error: Error, file: NSString = #file, line: UInt = #line, isPublic: Bool = false) {
    ESLog((error as NSError).localizedDescription, level: .error, isPublic: isPublic, file: file, line: line)
}

func ESLog(condition: @autoclosure () -> Bool, message: String) {
    assert(condition(), message)
}

func ESLog(_ message: String, level: ESLogLevel = .info, isPublic: Bool = false, includesCallerInfo: Bool = true, file: NSString = #file, line: UInt = #line) {

    #if DEBUG
    // Pass
    #else
    if !isPublic { return }
    #endif

    guard level <= ESLogger.verbosityLevel else { return }

    let symbol     = ESLogger.iconsEnabled ? level.symbol : ""
    let space      = " "
    let callerInfo = includesCallerInfo ? "[\(file.lastPathComponent):\(line)]" : ""
    print(callerInfo + space + symbol + space + message)
}
