//
//  SMColor.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/17.
//

import Foundation

struct SMColor {
    private let red: UInt8
    private let green: UInt8
    private let blue: UInt8

    init(red: UInt8, green: UInt8, blue: UInt8) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}

extension SMColor: CustomStringConvertible {
    var description: String {
        return "R: \(red) G: \(green), B: \(blue)"
    }
}
