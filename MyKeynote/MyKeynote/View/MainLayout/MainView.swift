//
//  MainView.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/19.
//

import UIKit
import OSLog

final class MainView: UIView {

    private let inspectorBarAreaCoverView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    private let navigationView = NavigatorView()
    private let inspectorView = InspectorView()

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

        addSubview(inspectorBarAreaCoverView)
        addSubview(navigationView)
        addSubview(inspectorView)
    }
}

extension MainView: LayoutConfigurable {
    func configureLayout() {
        inspectorBarAreaCoverView.frame = CGRect(origin: .zero,
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

        inspectorView.frame = CGRect(origin: CGPoint(x: bounds.width - sideBarWidth, y: safeAreaInsets.top),
                                  size: CGSize(width: sideBarWidth, height: bounds.height))
        inspectorView.configureLayout()
    }
}

extension MainView {
    func configureDelegate<T: InspectorDelegate>(_ delegator: T) {
        inspectorView.configureDelegate(delegator)
    }
}

// MARK: - API

// MARK: Setting
extension MainView {
    func settingStepperValueRange(min: Double, max: Double, step: Double) {
        inspectorView.settingStepperValueRange(min: min, max: max, step: step)
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

    func focusSelectedContent() {
        selectedSlideView?.focusContentView()
    }
    func defocusSelectedContent() {
        selectedSlideView?.defocusContentView()
    }

    func updateSelectedContentInspector(color: UIColor) {
        inspectorView.updateInspector(color: color)
    }
    func updateSelectedContentView(color: UIColor) {
        selectedSlideView?.updateContentView(color: color)
    }

    func updateSelectedContentInspector(alpha: Double) {
        inspectorView.updateInspector(alpha: alpha)
    }
    func updateSelectedContentView(alpha: Double) {
        selectedSlideView?.updateContentView(alpha: alpha)
    }

    func disenableColorInspector() {
        inspectorView.disenableColor()
    }

    func disenableAlphaInspector() {
        inspectorView.disenableAlpha()
    }
}
