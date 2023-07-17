//
//  Slide.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/17.
//

import Foundation

final class Slide {
    enum Constant {
        static let ratio: CGFloat = 3/4 // height / width
    }

    private let identifier: String = UUID().uuidString
    private let name: String
    private let width: Int
    private let height: Int
    private let color: SMColor
    private let alpha: SMAlpha

    init(name: String, width: Int, color: SMColor, alpha: SMAlpha) {
        self.name = name
        self.width = width
        self.height = Int(CGFloat(width) * Constant.ratio)
        self.color = color
        self.alpha = alpha
    }

    init(name: String, using generator: inout RandomNumberGenerator) {
        self.name = name
        self.width = Int.random(in: 0..<300, using: &generator)
        self.height = Int(CGFloat(width) * Constant.ratio)
        self.color = SMColor(using: &generator)
        self.alpha = SMAlpha(using: &generator)
    }
}

extension Slide: CustomStringConvertible {
    var description: String {
        //Rect1 (fxd-0fz-4b9), Side:216, R:245, G:0, B:245, Alpha: 9
        return "\(name) (\(identifier)), Side:\(width), \(color.description), Alpha: \(alpha.rawValue)"
    }
}
