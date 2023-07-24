//
//  SMAlpha+CGFloat.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/19.
//

import Foundation

extension CGFloat {
    init(_ smAlpha: SMAlpha) {
        self.init(smAlpha.rawValue)
    }
}

extension SMAlpha {
    init?(_ rawValue: CGFloat) {
        guard let alpha = SMAlpha(rawValue: Int(rawValue)) else { return nil }
        self = alpha
    }
}
