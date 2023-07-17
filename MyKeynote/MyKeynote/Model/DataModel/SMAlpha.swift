//
//  SMAlpha.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/17.
//

import Foundation

enum SMAlpha: Int, CaseIterable {
    case one = 1
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten

    var count: Int {
        return Self.allCases.count
    }

    init(using generator: inout RandomNumberGenerator) {
        let count = Self.allCases.count
        self = Self(rawValue: Int.random(in: 1...count, using: &generator)) ?? .one
    }
}
