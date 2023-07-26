//
//  SMAlpha.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/17.
//

import Foundation

enum SMAlpha: Int, CaseIterable {
    case zero = 0
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
}

extension SMAlpha {
    static var count: Int {
        return Self.allCases.count
    }

    static var min: Self {
        return .zero
    }

    static var max: Self {
        return .ten
    }

    static func random(using generator: inout RandomNumberGenerator) -> Self {
        let count = Self.allCases.count
        return Self(rawValue: Int.random(in: 1...count, using: &generator)) ?? .ten
    }
}

extension SMAlpha: Comparable {
    static func < (lhs: SMAlpha, rhs: SMAlpha) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

extension SMAlpha: Strideable {
    static var stepValue: Int {
        return Stride(1)
    }

    func distance(to other: SMAlpha) -> Int {
        return Stride(other.rawValue) - Stride(rawValue)
    }
    
    func advanced(by n: Int) -> SMAlpha {
        let index = Stride(rawValue) + n
        if let result = Self(rawValue: index) {
            return result
        } else if index < 0 {
            return .zero
        } else {
            return .ten
        }
    }
    
    typealias Stride = Int

}

extension SMAlpha: CustomStringConvertible {
    var description: String {
        return "\(rawValue)"
    }
}
