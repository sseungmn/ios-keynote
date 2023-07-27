//
//  SquareContentFactory.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/25.
//

import Foundation

protocol SquareContentFactoryProtocol: SlideContentFactory where Content == SquareContent {
    var maxSide: Int { get }
}

final class SquareContentFactory: SquareContentFactoryProtocol {

    let maxSide = 300

    func create(generator: inout RandomNumberGenerator) -> SquareContent {
        return Content(
            side: Int.random(in: 100..<maxSide, using: &generator),
            color: SMColor.random(using: &generator),
            alpha: SMAlpha.max
        )
    }
}
