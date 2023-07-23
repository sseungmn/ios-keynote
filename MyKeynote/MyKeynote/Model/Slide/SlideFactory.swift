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
