//
//  SlideFactory.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/18.
//

import Foundation

protocol SlideFactoryProtocol {
    
    func create<T: SlideContentFactory>(of ContentFactory: T.Type) -> Slide<T.Content>
}

final class SlideFactory: SlideFactoryProtocol {

    private var generator: RandomNumberGenerator

    init(using generator: RandomNumberGenerator) {
        self.generator = generator
    }

    convenience init() {
        self.init(using: SystemRandomNumberGenerator())
    }

    func create<T: SlideContentFactory>(of ContentFactory: T.Type) -> Slide<T.Content> {
        return Slide<T.Content>.init(content: ContentFactory.create(generator: &generator))
    }
}

protocol SlideContentFactory {
    associatedtype Content: SlideContent

    static func create(generator: inout RandomNumberGenerator) -> Content
}

final class SquareContentFactory: SlideContentFactory {
    typealias Content = SquareContent

    private static let maxWidth = 300

    static func create(generator: inout RandomNumberGenerator) -> Content {
        return Content(
            side: Int.random(in: 0..<maxWidth, using: &generator),
            color: SMColor.random(using: &generator),
            alpha: SMAlpha.random(using: &generator)
        )
    }
}
