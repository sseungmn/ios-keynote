//
//  MainView.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/19.
//

import UIKit

final class MainView: UIView {

    private let inspectorBarAreaCoverView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    private let navigatorView = NavigatorView()
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
        addSubview(navigatorView)
        addSubview(inspectorView)
    }
}

extension MainView: LayoutConfigurable {
    func configureLayout() {
        inspectorBarAreaCoverView.frame = CGRect(origin: .zero,
                                              size: CGSize(width: bounds.width, height: safeAreaInsets.top))
        let sideBarWidth = bounds.width / 7
        navigatorView.frame = CGRect(origin: CGPoint(x: safeAreaInsets.left, y: safeAreaInsets.top),
                                      size: CGSize(width: sideBarWidth, height: bounds.height - safeAreaInsets.top))
        navigatorView.configureLayout()

        let canvasViewHeight = (bounds.width - 2 * sideBarWidth) * (3/4)
        let canvasViewMinY = (bounds.height - canvasViewHeight) / 2
        slideViewFrame = CGRect(origin: CGPoint(x: sideBarWidth, y: canvasViewMinY),
                                  size: CGSize(width: bounds.width - 2 * sideBarWidth, height: bounds.height - 2 * canvasViewMinY))
        selectedSlideView?.configureLayout()

        inspectorView.frame = CGRect(origin: CGPoint(x: bounds.width - sideBarWidth, y: safeAreaInsets.top),
                                     size: CGSize(width: sideBarWidth, height: bounds.height - safeAreaInsets.top))
        inspectorView.configureLayout()
    }
}

// MARK: - API

// MARK: Setting
extension MainView {
    func settingStepperValueRange(min: Double, max: Double, step: Double) {
        inspectorView.settingStepperValueRange(min: min, max: max, step: step)
    }

    func settingInspectorViewDelegate(_ delegator: InspectorViewDelegate) {
        inspectorView.delegate = delegator
    }

    func settingNavigatorViewDelegate(_ delegator: NavigatorViewDelegate) {
        navigatorView.settingDelegate(delegator)
    }

    func settingNavigatorTableViewDelegate(_ delegator: UITableViewDelegate) {
        navigatorView.settingTableViewDelegate(delegator)
    }

    func settingNavigatorTableViewDataSource(_ dataSource: UITableViewDataSource) {
        navigatorView.settingTableViewDataSource(dataSource)
    }

    func settingNavigatorTableViewDragNDropDelegate<T>(_ delegator: T)
    where T: UITableViewDragDelegate & UITableViewDropDelegate {
        navigatorView.settingTableViewDragNDropDelegate(delegator)
    }
}

// MARK: Update
extension MainView {
    // MARK: NavigatorView
    func addSlideView(_ slideView: SlideView) {
        slideViews.append(slideView)
        addSubview(slideView)

        slideView.frame = slideViewFrame
        slideView.configureLayout()
    }

    func reloadNavigatorTableView() {
        navigatorView.reloadTableView()
    }

    func selectNavigatorTableView(at index: Int) {
        navigatorView.selectTableView(at: index)
    }

    // MARK: ContentView
    func focusSelectedContent() {
        selectedSlideView?.focusContentView()
    }
    func defocusSelectedContent() {
        selectedSlideView?.defocusContentView()
    }

    func updateSelectedContentView(color: UIColor) {
        selectedSlideView?.updateContentView(color: color)
    }
    func updateSelectedContentView(alpha: Double) {
        selectedSlideView?.updateContentView(alpha: alpha)
    }

    // MARK: InspectorView
    func updateSelectedContentInspector(color: UIColor) {
        inspectorView.updateInspector(color: color)
    }
    func updateSelectedContentInspector(alpha: Double) {
        inspectorView.updateInspector(alpha: alpha)
    }

    func disenableColorInspector() {
        inspectorView.disenableColor()
    }
    func disenableAlphaInspector() {
        inspectorView.disenableAlpha()
    }

    // MARK: Slide
    func selectSlideView(at index: Int) {
        selectedSlideView?.isHidden = true
        selectedSlideView = slideViews[index]
        selectedSlideView?.isHidden = false
    }
}
