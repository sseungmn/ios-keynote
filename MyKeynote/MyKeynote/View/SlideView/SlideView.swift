//
//  SlideView.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/19.
//

import UIKit

final class SlideView: UIView {

    private var contentView: ContentViewProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }

    func configureUI() {
        backgroundColor = .white
    }
}

extension SlideView: LayoutConfigurable {
    func configureLayout() {

    }
}

extension SlideView {
    func setContentView(_ contentView: ContentViewProtocol) {
        self.contentView = contentView
        addSubview(contentView)
    }

    func updateContentView(color: UIColor) {
        if let contentView = contentView as? ViewColorChangeable {
            contentView.updateColor(color)
        }
    }

    func updateContentView(alpha: Double) {
        contentView?.updateAlpha(alpha)
    }
}
