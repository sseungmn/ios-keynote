//
//  Slide.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/17.
//

import Foundation

class Slide {

    class var ratio: CGFloat { return 0 }

    private let identifier = SMUUID()
    private let name: String
    private(set) var size: SMSize
    private(set) var color: SMColor

    required init(name: String, width: Int, color: SMColor) {
        self.name = name
        self.size = SMSize(width: width, ratio: Self.ratio)
        self.color = color
    }
}

extension Slide: CustomStringConvertible {
    var description: String {
        return "\(name) (\(identifier)), \(size), \(color)"
    }
}
