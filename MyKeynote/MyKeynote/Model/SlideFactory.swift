//
//  SlideFactory.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/18.
//

import Foundation

protocol SlideFactorable {
    func create<T: Slide>(name: String, of Type: T.Type) -> T
}

final class SlideFactory: SlideFactorable {
    private var generator: RandomNumberGenerator
    private let maxWidth = 300

    init(using generator: RandomNumberGenerator) {
        self.generator = generator
    }

    convenience init() {
        self.init(using: SystemRandomNumberGenerator())
    }

    func create<T: Slide>(name: String, of Type: T.Type) -> T {
        return Type.init(
            name: name,
            width: Int.random(in: 1..<maxWidth, using: &generator),
            color: SMColor.random(using: &generator),
            alpha: SMAlpha.random(using: &generator)
        )
    }
}
