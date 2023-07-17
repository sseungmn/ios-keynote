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

    enum Alpha: Int {
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
    }

    private let identifier: String = UUID().uuidString
    private let name: String
    private let width: Int
    private let height: Int
    private let color: SMColor
    private let alpha: Alpha

    init(name: String, width: Int, color: SMColor, alpha: Alpha) {
        self.name = name
        self.width = width
        self.height = Int(CGFloat(width) * Constant.ratio)
        self.color = color
        self.alpha = alpha
    }
}

extension Slide: CustomStringConvertible {
    var description: String {
        //Rect1 (fxd-0fz-4b9), Side:216, R:245, G:0, B:245, Alpha: 9
        return "\(name) (\(identifier)), Side:\(width), \(color.description), Alpha: \(alpha.rawValue)"
    }
}
