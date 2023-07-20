//
//  Logger+Extension.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/19.
//

import Foundation
import OSLog

extension Logger {

    enum LogType {
        case info
        case error
    }

    static let main = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "com.minios.MyKeynote",
        category: "main"
    )

    static func track(
        message: String? =  nil,
        fileID: String = #fileID,
        function: String = #function,
        line: Int = #line,
        type: LogType = .info
    ) {
        let log = formattedString(message: message, fileID: fileID, function: function, line: line)
        switch type {
        case .info:
            main.info("\(log)")
        case .error:
            main.error("\(log)")
        }
    }

    private static func formattedString(
        message: String? =  nil,
        fileID: String = #fileID,
        function: String = #function,
        line: Int = #line
    ) -> String {
        var text = "\(fileID):\(function):\(line)"
        if let message {
            text = "- \(message)"
        }
        return text
    }
}
