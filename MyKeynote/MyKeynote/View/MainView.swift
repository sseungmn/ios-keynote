//
//  MainView.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/19.
//

import UIKit
import OSLog

final class MainView: UIView {

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

        addSubview(navigationView)
        addSubview(canvasView)
        addSubview(statusView)
    }
}

extension MainView: LayoutConfigurable {
    func configureLayout() {
        let sideBarWidth = bounds.width / 7
        navigationView.frame = CGRect(origin: .zero,
                                      size: CGSize(width: sideBarWidth, height: bounds.height))
        navigationView.configureLayout()

        let canvasViewMinY = bounds.height / 10
        canvasView.frame = CGRect(origin: CGPoint(x: sideBarWidth, y: canvasViewMinY),
                                  size: CGSize(width: bounds.width - 2 * sideBarWidth, height: bounds.height - 2 * canvasViewMinY))
        canvasView.configureLayout()

        statusView.frame = CGRect(origin: CGPoint(x: bounds.width - sideBarWidth, y: 0),
                                  size: CGSize(width: sideBarWidth, height: bounds.height))
        statusView.configureLayout()
    }
}
