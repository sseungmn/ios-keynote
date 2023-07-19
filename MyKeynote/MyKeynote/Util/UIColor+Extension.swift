//
//  UIColor+Extension.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/19.
//

import UIKit

extension UIColor {
    // https://gist.github.com/klein-artur/025a0fa4f167a648d9ea
    func complementaryColor() -> UIColor {
        let ciColor = CIColor(color: self)

        let compRed: CGFloat = 1.0 - ciColor.red
        let compGreen: CGFloat = 1.0 - ciColor.green
        let compBlue: CGFloat = 1.0 - ciColor.blue

        // https://stackoverflow.com/questions/1496716/how-do-i-get-red-green-blue-rgb-and-alpha-back-from-a-uicolor-object
        var alpha: CGFloat = 0.0
        getRed(nil, green: nil, blue: nil, alpha: &alpha)

        return UIColor(red: compRed, green: compGreen, blue: compBlue, alpha: alpha)
    }

    // https://stackoverflow.com/a/58158413/19782341
    var hexString: String {
        guard let components = cgColor.components else { return "" }
        return components[0..<3]
            .map { String(format: "%02lX", Int($0 * 255)) }
            .reduce("#", +)

    }
}
