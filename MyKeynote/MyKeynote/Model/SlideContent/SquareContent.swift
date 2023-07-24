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

    var side: Int
    var color: SMColor {
        didSet {
            NotificationCenter.default.post(name: .ContentColorDidChange, object: color)
        }
    }

    var alpha: SMAlpha {
        didSet {
            NotificationCenter.default.post(name: .ContentAlphaDidChange, object: alpha)
        }
    }

    init(side: Int, color: SMColor, alpha: SMAlpha) {
        self.side = side
        self.color = color
        self.alpha = alpha
        NotificationCenter.default.post(name: .ContentAlphaDidChange, object: alpha)
        NotificationCenter.default.post(name: .ContentColorDidChange, object: color)
    }
}
