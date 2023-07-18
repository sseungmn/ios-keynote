//
//  SMColor.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/17.
//

import Foundation

struct SMColor {
    
    private(set) var red: UInt8
    private(set) var green: UInt8
    private(set) var blue: UInt8
    private(set) var alpha: SMAlpha

    init(red: UInt8, green: UInt8, blue: UInt8, alpha: SMAlpha) {
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
            alpha: SMAlpha.random(in: SMAlpha.min..<SMAlpha.max, using: &generator)
        )
    }
}

extension SMColor: CustomStringConvertible {
    var description: String {
        return "R: \(red) G: \(green), B: \(blue), Alpha: \(alpha)"
    }
}
