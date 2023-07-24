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
    private let statusView = StatusView()

    private var slideViews = [SlideView]()
    var selectedSlideView: SlideView?
    private var slideViewFrame = CGRect.zero

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

        let canvasViewHeight = (bounds.width - 2 * sideBarWidth) * (3/4)
        let canvasViewMinY = (bounds.height - canvasViewHeight) / 2
        slideViewFrame = CGRect(origin: CGPoint(x: sideBarWidth, y: canvasViewMinY),
                                  size: CGSize(width: bounds.width - 2 * sideBarWidth, height: bounds.height - 2 * canvasViewMinY))
        selectedSlideView?.configureLayout()

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

// MARK: Setting
extension MainView {

    func settingStepperValueRange(min: Double, max: Double, step: Double) {
        statusView.settingStepperValueRange(min: min, max: max, step: step)
    }
}

// MARK: Update
extension MainView {

    func addSlideView(_ slideView: SlideView) {
        slideViews.append(slideView)
        addSubview(slideView)

        selectedSlideView = slideView
        slideView.frame = slideViewFrame
        slideView.configureLayout()
    }

    func updateSelectedSlideStatus(color: UIColor) {
        statusView.updateStatus(color: color)
    }
    func updateSelectedSlideContentView(color: UIColor) {
        selectedSlideView?.updateContentView(color: color)
    }

    func updateSelectedSlideStatus(alpha: Double) {
        statusView.updateStatus(alpha: alpha)
    }
    func updateSelectedSlideContentView(alpha: Double) {
        selectedSlideView?.updateContentView(alpha: alpha)
    }

    func updateSelectedSlideStatus(colorEnabled: Bool) {
        statusView.updateStatus(colorEnabled: colorEnabled)
    }

    func updateSelectedSlideStatus(alphaEnabled: Bool) {
        statusView.updateStatus(alphaEnabled: alphaEnabled)
    }
}
