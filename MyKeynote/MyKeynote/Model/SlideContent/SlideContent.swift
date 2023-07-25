//
//  SlideContent.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/23.
//

import Foundation

// MARK: - SlideContent Trait Protocol
protocol Focusable: AnyObject {
    var isFocused: Bool { get }

    func focus()
    func defocus()
}

protocol AlphaChangeable: AnyObject {
    var alpha: SMAlpha { get }

    func updateAlpha(_ alpha: SMAlpha)
}

protocol ColorChangeable: AnyObject {
    var color: SMColor { get }
    
    func updateColor(_ color: SMColor)
}

protocol SlideContent: Focusable, AlphaChangeable, CustomStringConvertible {
}

// MARK: Notification
extension Notification.Name {
    static let ContentDidFocus = Notification.Name("ContentDidFocus")
    static let ContentDidDefocus = Notification.Name("ContentDidDefocus")
    static let ContentAlphaDidChange = Notification.Name("ContentColorDidChange")
    static let ContentColorDidChange = Notification.Name("ContentAlphaDidChange")
}
