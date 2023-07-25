//
//  SMColor.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/17.
//

import Foundation

struct SMColor: Equatable {
    
    var red: UInt8
    var green: UInt8
    var blue: UInt8
    var alpha: SMAlpha

    init(red: UInt8, green: UInt8, blue: UInt8, alpha: SMAlpha = .ten) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }

    static func random(using generator: inout RandomNumberGenerator) -> Self {
        return SMColor(
            red: UInt8.random(in: 0..<UInt8.max, using: &generator),
            green: UInt8.random(in: 0..<UInt8.max, using: &generator),
            blue: UInt8.random(in: 0..<UInt8.max, using: &generator),
            alpha: SMAlpha.random(using: &generator)
        )
    }
}

extension SMColor {
    static var white: SMColor {
        return SMColor(red: .max, green: .max, blue: .max)
    }

    static var black: SMColor {
        return SMColor(red: .min, green: .min, blue: .min)
    }
}

extension SMColor: CustomStringConvertible {
    var description: String {
        return "R: \(red) G: \(green), B: \(blue), Alpha: \(alpha)"
    }
}
