//
//  Slide.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/17.
//

import Foundation

class Slide {
    class var ratio: CGFloat { return 0 }

    private let identifier: String = UUID().uuidString
    private let name: String
    private let size: SMSize
    private let color: SMColor
    private let alpha: SMAlpha

    init(name: String, width: Int, color: SMColor, alpha: SMAlpha) {
        self.name = name
        self.size = SMSize(width: width, ratio: Self.ratio)
        self.color = color
        self.alpha = alpha
    }

    init(name: String, using generator: inout RandomNumberGenerator) {
        self.name = name
        self.size = SMSize(ratio: Self.ratio, using: &generator)
        self.color = SMColor(using: &generator)
        self.alpha = SMAlpha(using: &generator)
    }
}

extension Slide: CustomStringConvertible {
    var description: String {
        return "\(name) (\(identifier)), Side:\(size.width), \(color.description), Alpha: \(alpha.rawValue)"
    }
}
