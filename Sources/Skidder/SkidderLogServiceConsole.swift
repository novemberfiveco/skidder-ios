//
//  SkidderLogServiceConsole.swift
//
//
//  Created by Jens Reynders on 22/06/2021.
//

import Foundation

public class SkidderLogServiceConsole: SkidderLogService {
    public var id: String
    public var logLevel: LogLevel = LogLevel.trace

    public init(id: String) {
        self.id = id
    }

    public func logBody(_ body: LogBody, with level: LogLevel) {
        guard level.rawValue >= logLevel.rawValue else {
            return
        }

        let rawBody = body.jsonString()

        let formattedMessage = """
        \(body.level) - \(body.message)
        \(rawBody ?? "nil")
        """

        print(formattedMessage)
    }
}
