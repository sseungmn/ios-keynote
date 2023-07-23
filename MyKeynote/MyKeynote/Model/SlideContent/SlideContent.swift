//
//  SlideContent.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/23.
//

import Foundation

// MARK: - SlideContent Trait Protocol
protocol AlphaChangeable: AnyObject {
    var alpha: SMAlpha { get set }
}

protocol ColorChangeable: AnyObject {
    var color: SMColor { get set }
}

protocol SlideContent: AlphaChangeable, CustomStringConvertible {

    var alpha: SMAlpha { get set }
}

// MARK: Notification
extension Notification.Name {
    static let ContentAlphaDidChange = Notification.Name("ContentColorDidChange")
    static let ContentColorDidChange = Notification.Name("ContentAlphaDidChange")
}

