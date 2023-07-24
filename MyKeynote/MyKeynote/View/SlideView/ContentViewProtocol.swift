//
//  ContentViewProtocol.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/24.
//

import UIKit

typealias ContentViewProtocol = UIView & ViewFocusable & ViewAlphaChangeable

// MARK: ViewSelectable
protocol ViewFocusable: UIView {

    func focus()
    func defocus()
}

extension ViewFocusable {

    func focus() {
        layer.borderWidth = 3.0
    }
    func defocus() {
        layer.borderWidth = 0.0
    }
}

// MARK: ViewAlphaChangeable
protocol ViewAlphaChangeable: UIView {

    var contentAlpha: CGFloat { get set }

    func updateAlpha(_ alpha: CGFloat)
}

// MARK: ViewColorChangeable
protocol ViewColorChangeable: ContentViewProtocol {

    var contentColor: UIColor { get set }

    func updateColor(_ color: UIColor)
    func updateAlpha(_ alpha: CGFloat)
}

extension ViewColorChangeable {

    func updateColor(_ color: UIColor) {
        contentColor = color
        backgroundColor = contentColor.withAlphaComponent(contentAlpha)
        layer.borderColor = (contentColor.isDark ? UIColor.systemTeal : UIColor.black).cgColor

    }

    func updateAlpha(_ alpha: CGFloat) {
        contentAlpha = alpha
        backgroundColor = contentColor.withAlphaComponent(contentAlpha)
    }
}
