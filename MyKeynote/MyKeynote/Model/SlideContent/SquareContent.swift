//
//  SquareContent.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/24.
//

import Foundation

final class SquareContent: SlideContent, ColorChangeable {

    private(set) var side: Int

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
        self.side = side
        self.color = color
        self.alpha = alpha
        postDidFocusNotification()
        postDidAlphaChangeNotification()
        postDidColorChangeNotification()
    }
}

// MARK: Notification
extension SquareContent {
    private func postDidFocusNotification() {
        NotificationCenter.default.post(name: .ContentDidFocus, object: self, userInfo: ["color": color, "alpha": alpha])
    }
    private func postDidDefocusNotification() {
        NotificationCenter.default.post(name: .ContentDidDefocus, object: self)
    }
    private func postDidAlphaChangeNotification() {
        NotificationCenter.default.post(name: .ContentAlphaDidChange, object: self, userInfo: ["alpha": alpha])
    }
    private func postDidColorChangeNotification() {
        NotificationCenter.default.post(name: .ContentColorDidChange, object: self, userInfo: ["color": color])
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
        return "Side: \(side), Color: \(color)"
    }
}
