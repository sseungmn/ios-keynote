//
//  UIColor+Extension.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/19.
//

import UIKit

extension UIColor {
    typealias RGB = (red: CGFloat, green: CGFloat, blue: CGFloat)
    
    var rgb: RGB {
        let ciColor = CIColor(color: self)

        return (red: ciColor.red, green: ciColor.green, blue: ciColor.blue)
    }

    // https://stackoverflow.com/a/58158413/19782341
    var hexString: String {
        guard let components = cgColor.components else { return "" }
        return components[0..<3]
            .map { String(format: "%02lX", Int($0 * 255)) }
            .reduce("#", +)

    }

    // https://stackoverflow.com/a/596243/19782341
    var isDark: Bool {
        let rgb = self.rgb

        let luminance = 0.299 * rgb.red + 0.587 * rgb.green + 0.114 * rgb.blue
        return luminance < 0.5
    }

    // https://gist.github.com/klein-artur/025a0fa4f167a648d9ea
    func complementaryColor() -> UIColor {
        let rgb = self.rgb

        return UIColor(red: 1 - rgb.red, green: 1 - rgb.green, blue: 1 - rgb.blue, alpha: 1.0)
    }
}
