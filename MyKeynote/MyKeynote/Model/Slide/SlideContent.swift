//
//  SlideContent.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/23.
//

import Foundation

// MARK: - SlideContent Protocol
protocol AlphaChangeable: AnyObject {
    var alpha: SMAlpha { get set }
}

protocol ColorChangeable: AnyObject {
    var color: SMColor { get set }
}

protocol SlideContent: AlphaChangeable, CustomStringConvertible {

    var alpha: SMAlpha { get set }
    var delegate: SlideContentDelegate? { get set }
}

extension Notification.Name {
    static let ContentAlphaDidChange = Notification.Name("ContentColorDidChange")
    static let ContentColorDidChange = Notification.Name("ContentAlphaDidChange")
}

// MARK: - SlideContent Concrete
final class SquareContent: SlideContent, ColorChangeable {

    var description: String {
        return "Side: \(side), Color: \(color)"
    }

    var side: Int
    var color: SMColor {
        didSet {
            NotificationCenter.default.post(name: .ContentColorDidChange, object: self)
            delegate?.colorDidChange(color)
        }
    }

    var alpha: SMAlpha {
        didSet {
            NotificationCenter.default.post(name: .ContentColorDidChange, object: self)
            delegate?.alphaDidChange(alpha)
        }
    }

    var delegate: SlideContentDelegate?

    init(side: Int, color: SMColor, alpha: SMAlpha) {
        self.side = side
        self.color = color
        self.alpha = alpha
    }
}
