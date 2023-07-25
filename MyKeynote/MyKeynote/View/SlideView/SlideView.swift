//
//  SlideView.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/19.
//

import UIKit

protocol SlideViewDelegate {
    func slideViewDidTap(_ isSlideContentArea: Bool)
}

final class SlideView: UIView {

    var contentView: ContentViewProtocol?
    var delegate: SlideViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }

    private func configureUI() {
        backgroundColor = .white

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(slideViewDidTap(_:)))
        addGestureRecognizer(tapGesture)
    }

    @objc
    private func slideViewDidTap(_ sender: UITapGestureRecognizer) {
        guard let contentView else { return }
        let isSlideContentArea = contentView.bounds.contains(sender.location(in: contentView))
        delegate?.slideViewDidTap(isSlideContentArea)
    }
}

extension SlideView: LayoutConfigurable {
    func configureLayout() {
    }
}

// MARK: - API

// MARK: Setting
extension SlideView {
    func setContentView(_ contentView: ContentViewProtocol) {
        self.contentView = contentView
        addSubview(contentView)
    }
}

// MARK: Update
extension SlideView {
    func updateContentView(color: UIColor) {
        if let contentView = contentView as? ViewColorChangeable {
            contentView.updateColor(color)
        }
    }
    func updateContentView(alpha: Double) {
        if let contentView = contentView as? ViewAlphaChangeable {
            contentView.updateAlpha(alpha)
        }
    }

    func focusContentView() {
        contentView?.focus()
    }
    func defocusContentView() {
        contentView?.defocus()
    }
}
