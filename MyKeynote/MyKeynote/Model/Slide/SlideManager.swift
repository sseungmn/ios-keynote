//
//  SlideManager.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/23.
//

import Foundation

final class SlideManager {

    enum SlideContentType {
        case square
        case image

        var factoryType: any SlideContentFactory.Type {
            switch self {
            case .square: return SquareContentFactory.self
            case .image: fatalError("Not implemented")
            }
        }
    }

    private let factory: SlideFactoryProtocol
    private var slides: [any Slidable] = []
    private var selectedSlide: (any Slidable)?
    private(set) var selectedContent: SlideContent?

    var slideCount: Int {
        return slides.count
    }

    subscript(_ index: Int) -> any Slidable {
        assert(0 <= index && index < slideCount)
        return slides[index]
    }

    init(factory: SlideFactoryProtocol) {
        self.factory = factory
    }
}

// MARK: - API
extension SlideManager {
    func createSlide(of contentType: SlideContentType) -> any Slidable {
        switch contentType {
        case .square:
            let slide = factory.create(of: SquareContentFactory.self)
            slides.append(slide)
            selectedSlide = slide
            selectedContent = slide.content
            return slide
        case .image:
            fatalError("Not implemented")
        }
    }

    func updateSelectedContent(color: SMColor) {
        if let content = selectedContent as? ColorChangeable {
            content.color = color
        }
    }

    func updateSelectedContent(alpha: SMAlpha) {
        if let content = selectedContent as? AlphaChangeable {
            content.alpha = alpha
        }
    }
}
