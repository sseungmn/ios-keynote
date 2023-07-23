//
//  SlideView.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/19.
//

import UIKit

final class SlideView: UIView {

    private var contentView: UIView?

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
    func setContentView(_ contentView: UIView) {
        self.contentView = contentView
        addSubview(contentView)
    }
}
