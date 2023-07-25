//
//  ViewController.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/17.
//

import UIKit
import OSLog

class ViewController: UIViewController {

    let slideManager: SlideManager

    private var mainView: MainView {
        return view as? MainView ?? MainView()
    }

    private let colorPickerView: UIColorPickerViewController = {
        let viewController = UIColorPickerViewController()
        viewController.supportsAlpha = false
        return viewController
    }()

    init(generator: RandomNumberGenerator = SystemRandomNumberGenerator(),
         squareContentFactory: SquareContentFactory = SquareContentFactory()
    ) {
        self.slideManager = SlideManager(
            generator: generator,
            squareContentFactory: squareContentFactory
        )
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()

        let mainView = MainView()
        mainView.frame = view.frame
        mainView.configureDelegate(self)
        mainView.settingStepperValueRange(min: Double(SMAlpha.min.rawValue), max: Double(SMAlpha.max.rawValue) , step: 1.0)
        view = mainView
    }

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        mainView.configureLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureDelegate()
        addObserverForSlideContent()
    }
}

// MARK: - View -> Controller -> Model

// MARK: InspectorView
extension ViewController {
    private func configureDelegate() {
        colorPickerView.delegate = self
        mainView.configureDelegate(self)
    }
}

extension ViewController: InspectorDelegate {
    func alphaStepperValueDidChange(_ sender: UIStepper) {
        guard let smAlpha = SMAlpha(sender.value) else {
            Logger.track(message: "alpha to SMAlpha convert Error", type: .error)
            return
        }
        slideManager.updateSelectedContent(alpha: smAlpha)
    }
    
    func colorPickerButtonDidTap(_ sender: UIButton) {
        colorPickerView.modalPresentationStyle = .popover
        colorPickerView.modalTransitionStyle = .crossDissolve
        colorPickerView.popoverPresentationController?.sourceView = sender
        present(colorPickerView, animated: true)
    }
}

extension ViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        if !continuously {
            slideManager.updateSelectedContent(color: SMColor(color) ?? .white)
        }
    }
}

// MARK: SlideView
extension ViewController: SlideViewDelegate {
    func slideViewDidTap(_ isSlideContentArea: Bool) {
        slideManager.updateSelectedContent(isFocused: isSlideContentArea)
    }
}

// MARK: NavigatorView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return slideManager.slideCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .darkGray
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        slideManager.selectSlide(at: indexPath.row)
    }
}

extension ViewController: NavigatorDelegate {
    func addSlideButtonDidTap(_ sender: UIButton) {
        slideManager.createSquareContentSlide()
    }
}

// MARK: - Model -> Controller -> View
extension ViewController {
    func addObserverForSlideContent() {
        NotificationCenter.default.addObserver(self, selector: #selector(slideContentColorDidChange(_:)), name: .Content.ColorDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(slideContentAlphaDidChange(_:)), name: .Content.AlphaDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(slideContentDidFocus(_:)), name: .Content.DidFocus, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(slideContentDidDefocus(_:)), name: .Content.DidDefocus, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(slideDidCreate(_:)), name: .Slide.DidCreate, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(slideDidSelect(_:)), name: .Slide.DidSelect, object: nil)
    }

    @objc
    func slideContentColorDidChange(_ notification: Notification) {
        guard let smColor = notification.userInfo?["color"] as? SMColor else {
            Logger.track(message: "Notification Object conversion Error", type: .error)
            return
        }
        let color = smColor.uiColor
        colorPickerView.selectedColor = color
        mainView.updateSelectedContentInspector(color: color)
        mainView.updateSelectedContentView(color: color)

        let initialAlpha = Double(SMAlpha.max.rawValue)
        mainView.updateSelectedContentView(alpha: initialAlpha)
        mainView.updateSelectedContentInspector(alpha: initialAlpha)
    }

    @objc
    func slideContentAlphaDidChange(_ notification: Notification) {
        guard let smAlpha = notification.userInfo?["alpha"] as? SMAlpha else {
            Logger.track(message: "Notification Object conversion Error", type: .error)
            return
        }
        let alpha = Double(smAlpha.rawValue)
        mainView.updateSelectedContentInspector(alpha: alpha)
        mainView.updateSelectedContentView(alpha: alpha / 10.0)
    }

    @objc
    func slideContentDidFocus(_ notification: Notification) {
        mainView.focusSelectedContent()
        if let smColor = notification.userInfo?["color"] as? SMColor {
            let color = smColor.uiColor
            mainView.updateSelectedContentView(color: color)
            mainView.updateSelectedContentInspector(color: color)
        }
        if let smAlpha = notification.userInfo?["alpha"] as? SMAlpha {
            let alpha = Double(smAlpha.rawValue)
            mainView.updateSelectedContentView(alpha: alpha)
            mainView.updateSelectedContentInspector(alpha: alpha)
        }
    }

    @objc
    func slideContentDidDefocus(_ notification: Notification) {
        mainView.defocusSelectedContent()
        mainView.disenableAlphaInspector()
        mainView.disenableColorInspector()
    }

    @objc
    func slideDidCreate(_ notification: Notification) {
        guard let slide = notification.userInfo?["slide"] as? Slide,
            let content = slide.content as? SquareContent
        else {
            Logger.track(message: "Notification Object conversion Error", type: .error)
            return
        }

        let contentView = SquareContentView()
        let slideView = SlideView(contentView: contentView)
        slideView.delegate = self
        mainView.addSlideView(slideView)
        mainView.reloadNavigatorTableView()
        mainView.selectNavigatorTableView(at: slideManager.slideCount - 1)

        contentView.updateSize(content.size.cgSize)
        contentView.updateAlpha(content.alpha.cgFloat)
        contentView.updateColor(content.color.uiColor)
    }

    @objc
    func slideDidSelect(_ notification: Notification) {
        guard let index = notification.userInfo?["index"] as? Int else {
            Logger.track(message: "Notification Object conversion Error", type: .error)
            return
        }
        mainView.selectSlideView(at: index)
    }
}
