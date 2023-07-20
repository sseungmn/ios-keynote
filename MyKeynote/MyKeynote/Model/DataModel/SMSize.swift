//
//  SMSize.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/17.
//

import Foundation

struct SMSize {
    
    private var ratio: Double?

    private(set) var width: Int {
        didSet {
            guard let ratio else { return }
            self.height = Int(Double(width) * ratio)
        }
    }

    private(set) var height: Int

    init(width: Int, ratio: Double) {
        self.width = width
        self.height = Int(Double(width) * ratio)
        self.ratio = ratio
    }

    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }

    static func random(in range: ClosedRange<Int>, using generator: inout RandomNumberGenerator, ratio: CGFloat) -> Self {
        let width = Int.random(in: range, using: &generator)
        return SMSize(width: width, ratio: ratio)
    }
}

extension SMSize: CustomStringConvertible {
    var description: String {
        return "Side: \(width)"
    }
}
