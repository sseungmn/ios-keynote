//
//  CanvasView.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/19.
//

import UIKit

final class CanvasView: UIView {

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

extension CanvasView: LayoutConfigurable {
    func configureLayout() {

    }
}
