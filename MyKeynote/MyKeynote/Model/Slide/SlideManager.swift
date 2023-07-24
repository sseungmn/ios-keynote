//
//  SlideManager.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/23.
//

import Foundation

extension Notification.Name {
    static let ContentDidSelect = Notification.Name("ContentDidSelect")
}

final class SlideManager {

    enum SlideContentType {
        case square
        case image
    }

    private var generator: RandomNumberGenerator
    private let squareContentFactory: any SlideContentFactory

    private var slides: [any Slidable] = []
    private var selectedSlide: (any Slidable)?
    private(set) var selectedContent: SlideContent?

    init(
        generator: RandomNumberGenerator,
        squareContentFactory: any SlideContentFactory
    ) {
        self.generator = generator
        self.squareContentFactory = squareContentFactory
    }

    var slideCount: Int {
        return slides.count
    }

    subscript(_ index: Int) -> any Slidable {
        assert(0 <= index && index < slideCount)
        return slides[index]
    }
}

extension SlideManager {
    private func select(slide: any Slidable) {
        selectedSlide = slide
        selectedContent = slide.content
        NotificationCenter.default.post(name: .ContentDidSelect, object: slide.content)
    }
}

// MARK: - API
extension SlideManager {
    func createSlide(of contentType: SlideContentType) -> Slidable {
        var slideContent: SlideContent
        switch contentType {
        case .square:
            slideContent = squareContentFactory.create(generator: &generator)
        case .image:
            fatalError("Not implemented")
        }
        let slide = Slide(content: slideContent)
        slides.append(slide)
        select(slide: slide)

        return slide
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
