//
//  NotificationNamespace.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/25.
//

import Foundation

extension Notification.Name {
    enum Content {
        static let DidFocus = Notification.Name("ContentDidFocus")
        static let DidDefocus = Notification.Name("ContentDidDefocus")
        static let AlphaDidChange = Notification.Name("ContentColorDidChange")
        static let ColorDidChange = Notification.Name("ContentAlphaDidChange")
    }
}
