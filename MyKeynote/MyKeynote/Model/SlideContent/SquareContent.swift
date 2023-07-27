//
//  SquareContent.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/24.
//

import Foundation

final class SquareContent: SlideContent, ColorChangeable {

    private(set) var size: SMSize

    private(set) var isFocused: Bool = false {
        didSet {
            if isFocused {
                postDidFocusNotification()
            } else {
                postDidDefocusNotification()
            }
        }
    }
    
    private(set) var color: SMColor {
        didSet {
            postDidColorChangeNotification()
        }
    }
    
    private(set) var alpha: SMAlpha {
        didSet {
            postDidAlphaChangeNotification()
        }
    }
    
    init(side: Int, color: SMColor, alpha: SMAlpha) {
        self.size = SMSize(side: side)
        self.color = color
        self.alpha = alpha
        postDidFocusNotification()
        postDidAlphaChangeNotification()
        postDidColorChangeNotification()
    }
}

// MARK: - API
extension SquareContent {
    func focus() {
        isFocused = true
    }
    func defocus() {
        isFocused = false
    }

    func updateColor(_ color: SMColor) {
        self.color = color
    }
    
    func updateAlpha(_ alpha: SMAlpha) {
        self.alpha = alpha
    }
}

// MARK: CustomStringConvertible
extension SquareContent {
    var description: String {
        return "Side: \(size.width), Color: \(color), Alpha: \(alpha)"
    }
}

// MARK: - Notification
extension SquareContent {
    private func postDidFocusNotification() {
        NotificationCenter.default.post(
            name: .Content.DidFocus,
            object: self,
            userInfo: ["color": color, "alpha": alpha]
        )
    }
    private func postDidDefocusNotification() {
        NotificationCenter.default.post(
            name: .Content.DidDefocus,
            object: self
        )
    }
    private func postDidAlphaChangeNotification() {
        NotificationCenter.default.post(
            name: .Content.AlphaDidChange,
            object: self,
            userInfo: ["alpha": alpha]
        )
    }
    private func postDidColorChangeNotification() {
        NotificationCenter.default.post(
            name: .Content.ColorDidChange,
            object: self,
            userInfo: ["color": color]
        )
    }
}
