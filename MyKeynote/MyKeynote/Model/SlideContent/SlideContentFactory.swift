//
//  SlideContentFactory.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/24.
//

import Foundation

protocol SlideContentFactory: AnyObject {
    associatedtype Content: SlideContent

    func create(generator: inout RandomNumberGenerator) -> Content
}

final class SquareContentFactory: SlideContentFactory {
    typealias Content = SquareContent

    private let maxWidth = 300

    func create(generator: inout RandomNumberGenerator) -> Content {
        return Content(
            side: Int.random(in: 100..<maxWidth, using: &generator),
            color: SMColor.random(using: &generator),
            alpha: SMAlpha.max
        )
    }
}
