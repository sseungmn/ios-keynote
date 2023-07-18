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

    static func random(using generator: inout RandomNumberGenerator) -> Self {
        let count = Self.allCases.count
        let rawValue = Int.random(in: 1...count, using: &generator)
        return Self(rawValue: rawValue) ?? .one
    }

    init(using generator: inout RandomNumberGenerator) {
        let count = Self.allCases.count
        self = Self(rawValue: Int.random(in: 1...count, using: &generator)) ?? .one
    }
}


