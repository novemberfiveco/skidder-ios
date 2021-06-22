//
//  Skidder+Level.swift
//  
//
//  Created by Jens Reynders on 22/06/2021.
//

import Foundation

public enum LogLevel: Int {
    case trace = 0
    case debug
    case info
    case warn
    case error
    case fatal

    var description: String {
        switch self {
        case .trace:
            return "TRACE"
        case .debug:
            return"DEBUG"
        case .info:
            return "INFO"
        case .warn:
            return "WARN"
        case .error:
            return "ERROR"
        case .fatal:
            return "FATAL"
        }
    }
}
