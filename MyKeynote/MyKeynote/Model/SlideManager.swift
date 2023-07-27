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
    func createSquareContentSlide() {
        let squareContent = squareContentFactory.create(generator: &generator)
        let slide = Slide(content: squareContent)
        Logger.track(message: "\(slide)")
        slides.append(slide)
        postDidCreateNotification(for: slide)
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

extension SlideManager {
    func selectSlide(at index: Int) {
        selectedSlide = slides[index]
        postDidSelectNotification(for: index)

        selectedContent = slides[index].content
        selectedContent?.focus()
        postDidFocusNotification(for: selectedContent!)
    }

    func deselectSlide() {
        selectedSlide = nil
        postDidDeselectNotification()

        selectedContent = nil
        postDidDefocusNotification()
    }

    func moveSlide(at sourceIndex: Int, to destinationIndex: Int) {
        guard sourceIndex != destinationIndex else { return }

        let slide = slides[sourceIndex]
        slides.remove(at: sourceIndex)
        slides.insert(slide, at: destinationIndex)
    }
}

// MARK: - Notification
extension SlideManager {
    private func postDidCreateNotification(for slide: Slide) {
        NotificationCenter.default.post(
            name: .Slide.DidCreate,
            object: self,
            userInfo: ["slide": slide]
        )
    }

    private func postDidSelectNotification(for index: Int) {
        NotificationCenter.default.post(
            name: .Slide.DidSelect,
            object: self,
            userInfo: ["index": index]
        )
    }

    private func postDidDeselectNotification() {
        NotificationCenter.default.post(
            name: .Slide.DidDeselect,
            object: self
        )
    }

    private func postDidFocusNotification(for slideContent: SlideContent) {
        NotificationCenter.default.post(
            name: .Content.DidFocus,
            object: self,
            userInfo: ["color": (slideContent as? ColorChangeable)?.color,
                       "alpha": (slideContent as? AlphaChangeable)?.alpha]
        )
    }

    private func postDidDefocusNotification() {
        NotificationCenter.default.post(
            name: .Content.DidDefocus,
            object: self
        )
    }
}
