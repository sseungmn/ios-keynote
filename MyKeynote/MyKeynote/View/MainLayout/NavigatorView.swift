//
//  NavigatorView.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/19.
//

import UIKit

protocol NavigatorDelegate {
    func addSlideButtonDidTap(_ sender: UIButton)
}

final class NavigatorView: UIView {

    private let tableView = UITableView()
    private let addSlideButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(systemName: "plus"), for: .normal)
        button.backgroundColor = .systemBlue.withAlphaComponent(0.5)
        button.layer.cornerRadius = 10.0
        return button
    }()

    var delegate: NavigatorDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }

    private func configureUI() {
        backgroundColor = .systemGray5

        addSubview(tableView)
        addSubview(addSlideButton)

        addSlideButton.addTarget(self, action: #selector(addSlideButtonDidTap(_:)), for: .touchUpInside)
    }

    @objc
    private func addSlideButtonDidTap(_ sender: UIButton) {
        delegate?.addSlideButtonDidTap(sender)
    }
}

extension NavigatorView: LayoutConfigurable {
    func configureLayout() {
        let addSlideButtonHeight: CGFloat = 80
        addSlideButton.frame = CGRect(origin: CGPoint(x: 0, y: frame.height - addSlideButtonHeight),
                                      size: CGSize(width: bounds.width, height: addSlideButtonHeight))
        tableView.frame = CGRect(origin: .zero,
                                 size: CGSize(width: bounds.width, height: addSlideButton.frame.minY)
        )
    }
}

// MARK: - API
extension NavigatorView {
    func configureDelegate(_ viewController: UITableViewDelegate & UITableViewDataSource & NavigatorDelegate) {
        tableView.delegate = viewController
        tableView.dataSource = viewController
        self.delegate = viewController
    }

    func reloadTableView() {
        tableView.reloadData()
    }
}
