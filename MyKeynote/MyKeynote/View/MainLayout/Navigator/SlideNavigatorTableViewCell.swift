//
//  SlideNavigatorTableViewCell.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/26.
//

import UIKit
import OSLog

final class SlideNavigatorTableViewCell: UITableViewCell {

    static let identifier: String = String(describing: SlideNavigatorTableViewCell.self)
    static let intrinsicContentHeight: CGFloat = 100.0

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.layer.borderWidth = 10.0
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.layer.cornerRadius = 10.0
        return view
    }()

    private let slideSymbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .darkGray
        return imageView
    }()

    override func prepareForReuse() {
        configure(title: nil, image: nil)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }

    private func configureUI() {
        addSubview(titleLabel)
        addSubview(containerView)
        containerView.addSubview(slideSymbolImageView)
    }

    func configure(title: String?, image: UIImage?) {
        titleLabel.text = title
        slideSymbolImageView.image = image
    }
}

extension SlideNavigatorTableViewCell: LayoutConfigurable {
    func configureLayout() {
        let containerViewHeight = frame.height
        let containerViewWidth = containerViewHeight * (4/3)
        containerView.frame.size = CGSize(width: containerViewWidth, height: containerViewHeight)
        containerView.frame.origin = CGPoint(x: frame.width - containerViewWidth, y: 0)

        slideSymbolImageView.frame.size = CGSize(width: containerViewWidth / 2, height: containerViewHeight / 2)
        slideSymbolImageView.center = CGPoint(x: containerViewWidth / 2, y: containerViewHeight / 2)

        titleLabel.sizeToFit()
        titleLabel.frame.origin.x = containerView.frame.minX - titleLabel.frame.width - 5
        titleLabel.frame.origin.y = frame.height - titleLabel.frame.height
    }
}
