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

    static func random(in range: ClosedRange<Int>, using generator: inout RandomNumberGenerator, ratio: CGFloat) -> Self {
        let width = Int.random(in: range, using: &generator)
        return SMSize(width: width, ratio: ratio)
    }
}
