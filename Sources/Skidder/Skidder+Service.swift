//
//  Skidder+Service.swift
//
//
//  Created by Jens Reynders on 22/06/2021.
//

import Foundation

public protocol SkidderLogService {
    var id: String { get set }
    var logLevel: LogLevel { get set }

    func logBody(_ body: LogBody, with level: LogLevel)
}
