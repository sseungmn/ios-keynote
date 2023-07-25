//
//  SlideManager.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/23.
//

import Foundation
import OSLog

final class SlideManager {

    private var generator: RandomNumberGenerator
    private let squareContentFactory: any SquareContentFactoryProtocol

    private var slides: [any Slidable] = []
    private var selectedSlide: (any Slidable)?
    private(set) var selectedContent: SlideContent?

    init(
        generator: RandomNumberGenerator,
        squareContentFactory: any SquareContentFactoryProtocol
    ) {
        self.generator = generator
        self.squareContentFactory = squareContentFactory
    }
}

extension SlideManager {
    private func select(slide: any Slidable) {
        selectedSlide = slide
        selectedContent = slide.content
        focus(on: slide.content)
    }

    private func focus(on slideContent: SlideContent) {
        slideContent.focus()
        postDidFocusNotification(for: slideContent)
    }
}

// MARK: Notification
extension SlideManager {
    private func postDidFocusNotification(for slideContent: SlideContent) {
        NotificationCenter.default.post(
            name: .Content.DidFocus,
            object: self,
            userInfo: ["color": (slideContent as? ColorChangeable)?.color,
                       "alpha": (slideContent as? AlphaChangeable)?.alpha]
        )
    }
}

// MARK: - API
// MARK: Getter
extension SlideManager {
    var slideCount: Int {
        return slides.count
    }
    
    subscript(_ index: Int) -> (any Slidable)? {
        return 0..<slideCount ~= index ? slides[index] : nil
    }
}

// MARK: Create
extension SlideManager {
    func createSquareContentSlide(_ completion: @escaping (SquareContent) -> Void) {
        let squareContent = squareContentFactory.create(generator: &generator)
        let slide = Slide(content: squareContent)
        Logger.track(message: "\(slide)")
        slides.append(slide)
        select(slide: slide)
        completion(squareContent)
    }

    func createImageContentSide() -> Slidable {
        fatalError("Not Implemented")
    }
}

// MARK: Update
extension SlideManager {

    func updateSelectedContent(color: SMColor) {
        if let content = selectedContent as? ColorChangeable {
            content.updateColor(color)
        }
    }

    func updateSelectedContent(alpha: SMAlpha) {
        if let content = selectedContent as? AlphaChangeable {
            content.updateAlpha(alpha)
        }
    }

    func updateSelectedContent(isFocused: Bool) {
        if let content = selectedContent as? Focusable {
            if isFocused { content.focus() }
            else { content.defocus() }
        }
    }
}
