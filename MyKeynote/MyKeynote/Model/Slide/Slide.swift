//
//  Slide.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/17.
//

import Foundation

class Slide {

    class var ratio: CGFloat { return 0 }

    private let identifier = SMUUID()
    private let name: String
    private let size: SMSize
    private let color: SMColor
    private let alpha: SMAlpha

    required init(name: String, width: Int, color: SMColor, alpha: SMAlpha) {
        self.name = name
        self.size = SMSize(width: width, ratio: Self.ratio)
        self.color = color
        self.alpha = alpha
    }
}

extension Slide: CustomStringConvertible {
    var description: String {
        return "\(name) (\(identifier)), \(size), \(color), \(alpha)"
    }
}
