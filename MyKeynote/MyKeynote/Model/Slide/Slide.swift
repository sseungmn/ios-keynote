//
//  Slide.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/17.
//

import Foundation

//protocol SlideDelegate: Slide, ColorChangeable, AlphaChangeable {
//
//    func colorDidChange()
//    func alphaDidChange()
//}

protocol AlphaChangeable: SlideContent {
    var alpha: SMAlpha { get set }
}

protocol ColorChangeable: SlideContent {
    var color: SMColor { get set }
}

//class Slide {
//
//    let identifier = SMUUID()
//    var content: SlideContent
//    init(content: SlideContent) {
//        self.content = content
//    }
//}

protocol Slidable {
    associatedtype Content
    
    var identifier: SMUUID { get }
    var content: Content { get }
    init(content: Content)
}

final class Slide<Content>: Slidable {

    let identifier: SMUUID = SMUUID()
    var content: Content
    init(content: Content) {
        self.content = content
    }
}

//final class SquareSlide: Slide {
//
//    typealias Content = SquareContent
//
//    let identifier: SMUUID = SMUUID()
//
//    var content: Content
//    init(content: Content) {
//        self.content = content
//    }
//}
//
//class Slide<Content: SlideContent> {
//
//    var content: Content
//    private var identifier: SMUUID
//
//    init(content: Content) {
//        self.identifier = SMUUID()
//        self.content = content
//    }
//}

//extension Slide where Content: SquareContent {
//    init(side: Int, color: SMColor, alpha: SMAlpha) {
//        var content = SquareContent(side: side, color: color, alpha: alpha)
//        self.init(content: content as! Self.Content)
//    }
//}

protocol SlideContent: AnyObject {

    var side: Int { get }
}

final class SquareContent: SlideContent, ColorChangeable, AlphaChangeable {

    var side: Int
    var color: SMColor
    var alpha: SMAlpha

    init(side: Int, color: SMColor, alpha: SMAlpha) {
        self.side = side
        self.color = color
        self.alpha = alpha
    }
}

//extension Slide: CustomStringConvertible {
//    var description: String {
//        return "\(name) (\(identifier)), \(size), \(color)"
//    }
//}
