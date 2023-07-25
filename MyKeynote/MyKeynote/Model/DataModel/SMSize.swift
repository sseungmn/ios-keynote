//
//  SMSize.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/17.
//

import Foundation

struct SMSize {
    
    private(set) var width: Int
    private(set) var height: Int

    init(side: Int) {
        self.width = side
        self.height = side
    }

    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
}

extension SMSize {
    static func random(in range: Range<Int>, using generator: inout RandomNumberGenerator) -> Self {
        return Self(width: Int.random(in: range, using: &generator),
                    height: Int.random(in: range, using: &generator)
        )
    }
}

extension SMSize: CustomStringConvertible {
    var description: String {
        return "Side: \(width)"
    }
}
