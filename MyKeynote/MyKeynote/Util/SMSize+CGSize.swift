//
//  SMSize+CGSize.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/19.
//

import Foundation

extension SMSize {
    var cgSize: CGSize {
        return CGSize(width: width, height: height)
    }

    init(_ cgSize: CGSize) {
        self.init(width: Int(cgSize.width), height: Int(cgSize.height))
    }
}
