//
//  MainView.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/19.
//

import UIKit
import OSLog

final class MainView: UIView {

    private let statusBarAreaCoverView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    private let navigationView = NavigatorView()
    private let canvasView = CanvasView()
    private let statusView = StatusView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }

    private func configureUI() {
        backgroundColor = .systemGray2

        addSubview(statusBarAreaCoverView)
        addSubview(navigationView)
        addSubview(canvasView)
        addSubview(statusView)
    }
}

extension MainView: LayoutConfigurable {
    func configureLayout() {
        statusBarAreaCoverView.frame = CGRect(origin: .zero,
                                              size: CGSize(width: bounds.width, height: safeAreaInsets.top))
        let sideBarWidth = bounds.width / 7
        navigationView.frame = CGRect(origin: CGPoint(x: safeAreaInsets.left, y: safeAreaInsets.top),
                                      size: CGSize(width: sideBarWidth, height: bounds.height))
        navigationView.configureLayout()

        let canvasViewMinY = bounds.height / 10
        canvasView.frame = CGRect(origin: CGPoint(x: sideBarWidth, y: canvasViewMinY),
                                  size: CGSize(width: bounds.width - 2 * sideBarWidth, height: bounds.height - 2 * canvasViewMinY))
        canvasView.configureLayout()

        statusView.frame = CGRect(origin: CGPoint(x: bounds.width - sideBarWidth, y: safeAreaInsets.top),
                                  size: CGSize(width: sideBarWidth, height: bounds.height))
        statusView.configureLayout()
    }
}

extension MainView {
    func configureDelegate<T: StatusDelegate>(_ delegator: T) {
        statusView.configureDelegate(delegator)
    }
}

// MARK: - API
extension MainView {
    func configureColorStatus(_ color: UIColor) {
        statusView.configureColorStatus(color)
    }
}
