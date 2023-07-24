//
//  SquareContent.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/24.
//

import Foundation

final class SquareContent: SlideContent, ColorChangeable {

    var description: String {
        return "Side: \(side), Color: \(color)"
    }

    private(set) var side: Int

    private(set) var isFocused: Bool = false {
        didSet {
            if isFocused {
                NotificationCenter.default.post(name: .ContentDidFocus, object: self)
            } else {
                NotificationCenter.default.post(name: .ContentDidDefocus, object: nil)
            }
        }
    }

    private(set) var color: SMColor {
        didSet {
            NotificationCenter.default.post(name: .ContentColorDidChange, object: color)
        }
    }

    private(set) var alpha: SMAlpha {
        didSet {
            NotificationCenter.default.post(name: .ContentAlphaDidChange, object: alpha)
        }
    }

    init(side: Int, color: SMColor, alpha: SMAlpha) {
        self.side = side
        self.color = color
        self.alpha = alpha
        NotificationCenter.default.post(name: .ContentDidFocus, object: self)
        NotificationCenter.default.post(name: .ContentAlphaDidChange, object: alpha)
        NotificationCenter.default.post(name: .ContentColorDidChange, object: color)
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
