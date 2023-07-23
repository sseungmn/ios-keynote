//
//  ContentViewProtocol.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/24.
//

import UIKit

typealias ContentViewProtocol = UIView & ViewSelectable & ViewAlphaChangeable

// MARK: ViewSelectable
protocol ViewSelectable: UIView {

    func select()
    func unselect()
}

extension ViewSelectable {

    func select() {
        layer.borderWidth = 3.0
    }

    func unselect() {
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
        contentColor = color.withAlphaComponent(contentAlpha)
        backgroundColor = contentColor
        layer.borderColor = (contentColor.isDark ? UIColor.systemTeal : UIColor.black).cgColor

    }

    func updateAlpha(_ alpha: CGFloat) {
        contentAlpha = alpha
        updateColor(contentColor.withAlphaComponent(contentAlpha))
    }
}
