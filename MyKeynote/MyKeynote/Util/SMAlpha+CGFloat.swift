//
//  SMAlpha+CGFloat.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/19.
//

import Foundation

extension SMAlpha {
    init?(_ rawValue: CGFloat) {
        guard let alpha = SMAlpha(rawValue: Int(rawValue)) else { return nil }
        self = alpha
    }

    var cgFloat: CGFloat {
        return CGFloat(rawValue)
    }
}
