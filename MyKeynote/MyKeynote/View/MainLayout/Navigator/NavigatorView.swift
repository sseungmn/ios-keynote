//
//  NavigatorView.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/19.
//

import UIKit

protocol NavigatorViewDelegate: NSObject {
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

    weak var delegate: NavigatorViewDelegate?

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

// MARK: Setting
extension NavigatorView {
    func settingDelegate(_ delegator: NavigatorViewDelegate) {
        self.delegate = delegator
    }

    func settingTableViewDelegate(_ delegator: UITableViewDelegate) {
        tableView.delegate = delegator
    }

    func settingTableViewDataSource(_ dataSource: UITableViewDataSource) {
        tableView.dataSource = dataSource
    }

    func settingTableViewDragNDropDelegate<T>(_ delegator: T)
    where T: UITableViewDragDelegate & UITableViewDropDelegate {
        tableView.dragDelegate = delegator
        tableView.dropDelegate = delegator
        tableView.dragInteractionEnabled = true
    }

    func registerTableViewCell(_ aClass: AnyClass?, forCellReuseIdentifier: String) {
        tableView.register(aClass, forCellReuseIdentifier: forCellReuseIdentifier)
    }
}

extension NavigatorView {
    func reloadTableView() {
        tableView.reloadData()
    }

    func selectTableView(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .middle)
        tableView.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
    }

    func deselectTableView(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        tableView.deselectRow(at: indexPath, animated: false)
        tableView.delegate?.tableView?(tableView, didDeselectRowAt: indexPath)
    }
}
