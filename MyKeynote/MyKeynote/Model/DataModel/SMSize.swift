//
//  SMSize.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/17.
//

import Foundation

struct SMSize {
    private var ratio: CGFloat

    var width: Int
    var height: Int {
        return Int(CGFloat(width) * ratio)
    }

    init(width: Int, ratio: CGFloat) {
        self.width = width
        self.ratio = ratio
    }

    init(ratio: CGFloat, using generator: inout RandomNumberGenerator) {
        self.width = Int.random(in: 1..<300, using: &generator)
        self.ratio = ratio
    }
}
