//
//  Slide.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/17.
//

import Foundation

class Slide {

    class var ratio: Double { return 0 }

    private let identifier = SMUUID()
    private let name: String
    private(set) var size: SMSize
    private(set) var color: SMColor
    private(set) var alpha: SMAlpha

    required init(name: String, width: Int, color: SMColor, alpha: SMAlpha) {
        self.name = name
        self.size = SMSize(width: width, ratio: Self.ratio)
        self.color = color
        self.alpha = alpha
    }
}

// API
extension Slide {
    func setColor(_ color: SMColor) {
        self.color = color
    }

    func setAlpha(_ alpha: SMAlpha) {
        self.color.alpha = alpha
        self.alpha = alpha
    }
}

extension Slide: CustomStringConvertible {
    var description: String {
        return "\(name) (\(identifier)), \(size), \(color)"
    }
}
