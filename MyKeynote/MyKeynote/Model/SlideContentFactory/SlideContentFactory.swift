//
//  SlideContentFactory.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/24.
//

import Foundation

protocol SlideContentFactory: AnyObject {
    associatedtype Content: SlideContent

    func create(generator: inout RandomNumberGenerator) -> Content
}
