//
//  Slide.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/17.
//

import Foundation

protocol Slidable {
    var identifier: SMUUID { get }
    var content: SlideContent { get set }
    
    init(content: SlideContent)
}

final class Slide: Slidable {

    let identifier: SMUUID = SMUUID()
    var content: SlideContent

    init(content: SlideContent) {
        self.content = content
    }
}

extension Slide: CustomStringConvertible {
    var description: String {
        return "(\(identifier)), \(content)"
    }
}
