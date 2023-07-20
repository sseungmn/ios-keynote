//
//  SMColor+UIColor.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/19.
//

import UIKit

extension SMColor {

    var uiColor: UIColor {
        return UIColor(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(alpha) / 10.0
        )
    }

    init(_ uiColor: UIColor) {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0

        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        // UIColor의 Alpha값은 0.0...1.0 이기 때문에 범위에서 벗어나지 않음.
        self.init(
            red:UInt8(red * 255.0),
            green: UInt8(green * 255.0),
            blue: UInt8(blue * 255.0),
            alpha: SMAlpha(alpha * 10)!
        )
    }
}
