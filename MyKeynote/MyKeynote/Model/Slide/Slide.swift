//
//  Slide.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/17.
//

import Foundation

protocol SlideContentDelegate {

    func alphaDidChange(_ alpha: SMAlpha)
    func colorDidChange(_ color: SMColor)
    func imageDidChange(_ image: Data)
}

protocol Slidable {
    associatedtype Content: SlideContent

    var identifier: SMUUID { get }
    var content: Content { get set }
    init(content: Content)
}

final class Slide<Content: SlideContent>: Slidable {
    let identifier: SMUUID = SMUUID()
    var content: Content
    init(content: Content) {
        self.content = content
    }
}

extension Slide: CustomStringConvertible {
    var description: String {
        return "(\(identifier)), \(content)"
    }
}
