//
//  Logger+Extension.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/19.
//

import Foundation
import OSLog

extension Logger {

    static let main = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "com.minios.MyKeynote",
        category: "main"
    )
}
