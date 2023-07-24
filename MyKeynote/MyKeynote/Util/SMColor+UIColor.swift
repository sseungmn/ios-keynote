//
//  SMColor+UIColor.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/19.
//

import UIKit
import OSLog

extension SMColor {
    var uiColor: UIColor {
        return UIColor(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(alpha) / 10.0
        )
    }

    init?(_ uiColor: UIColor) {
        let rgba = uiColor.rgba

        // UIColor의 Alpha값은 0.0...1.0 이기 때문에 범위에서 벗어나지 않음.
        self.init(
            red: UInt8(rgba.red * 255.0),
            green: UInt8(rgba.green * 255.0),
            blue: UInt8(rgba.blue * 255.0),
            alpha: SMAlpha(rgba.alpha * 10)!
        )
    }
}
