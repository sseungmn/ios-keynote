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
            alpha: 1.0
        )
    }

    init?(_ uiColor: UIColor) {
        let rgb = uiColor.rgb

        self.init(
            red: UInt8(rgb.red * 255.0),
            green: UInt8(rgb.green * 255.0),
            blue: UInt8(rgb.blue * 255.0)
        )
    }
}
