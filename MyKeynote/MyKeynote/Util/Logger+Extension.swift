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

    @inline(__always) static func track(
        fileID: String = #fileID,
        function: String = #function,
        line: Int = #line
    ) {
        main.info("\(fileID) - \(function):\(line)")
    }
}
