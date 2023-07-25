//
//  UIColor+Extension.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/19.
//

import UIKit

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let ciColor = CIColor(color: self)

        var alpha: CGFloat = 0.0
        getRed(nil, green: nil, blue: nil, alpha: &alpha)

        return (red: ciColor.red, green: ciColor.green, blue: ciColor.blue, alpha: ciColor.alpha)
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
        let rgba = self.rgba

        let luminance = 0.299 * rgba.red + 0.587 * rgba.green + 0.114 * rgba.blue
        return luminance < 0.5
    }

    // https://gist.github.com/klein-artur/025a0fa4f167a648d9ea
    func complementaryColor() -> UIColor {
        let rgba = self.rgba

        return UIColor(red: 1 - rgba.red, green: 1 - rgba.green, blue: 1 - rgba.blue, alpha: rgba.alpha)
    }
}
