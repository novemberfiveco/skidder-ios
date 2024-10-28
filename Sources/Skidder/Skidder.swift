//
//  Skidder.swift
//
//
//  Created by Jens Reynders on 22/06/2021.
//

import Foundation

public typealias LogData = [String: String]

extension Encodable {
    func encoded() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}

public struct LogBody: Encodable {
    public let timestamp: String
    public let level: String
    public let message: String
    public let data: LogData?
    public let environment: String?
    public let global: LogData?
}

public extension LogBody {
    func jsonString() -> String? {
        if let jsonData = try? encoded() {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        }
        return nil
    }
}

public class Skidder {
    public static let `default` = Skidder()

    public var logLevel = LogLevel.info
    public var environment: String?

    private var services: [SkidderLogService] = []
    private var globalData: LogData = [:]

    public func setGlobal(key: String, value: String?) {
        if let value = value {
            globalData[key] = value
        } else {
            globalData.removeValue(forKey: key)
        }
    }

    private init() {}

    // MARK: - Public

    // Getters & Setters
    public func addService(_ service: SkidderLogService) {
        guard !services.contains(where: { $0.id == service.id }) else { return }

        services.append(service)
    }

    public func removeService(for id: String) {
        services = services.filter({ $0.id != id })
    }

    private func log(with level: LogLevel, message: String, data: LogData? = nil) {
        guard level.rawValue >= logLevel.rawValue else { return }

        let timeStamp = dateFormatter.string(from: Date())
        let body = LogBody(timestamp: timeStamp, level: level.description, message: message, data: data, environment: environment, global: globalData)

        services.forEach({ $0.logBody(body, with: level) })
    }

    public static func log(with level: LogLevel, message: String, data: LogData? = nil) {
        Skidder.default.log(with: level, message: message, data: data)
    }

    // MARK: - Private convenience

    private let dateFormatter = ISO8601DateFormatter()
}

public func logTrace(_ message: String, data: LogData? = nil) {
    Skidder.log(with: .trace, message: message, data: data)
}

public func logDebug(_ message: String, data: LogData? = nil) {
    Skidder.log(with: .debug, message: message, data: data)
}

public func logInfo(_ message: String, data: LogData? = nil) {
    Skidder.log(with: .info, message: message, data: data)
}

public func logWarn(_ message: String, data: LogData? = nil) {
    Skidder.log(with: .warn, message: message, data: data)
}

public func logError(_ message: String, data: LogData? = nil) {
    Skidder.log(with: .error, message: message, data: data)
}

public func logFatal(_ message: String, data: LogData? = nil) {
    Skidder.log(with: .fatal, message: message, data: data)
}
