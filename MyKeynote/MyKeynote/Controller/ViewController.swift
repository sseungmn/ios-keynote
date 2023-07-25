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

extension ViewController: SlideViewDelegate {
    func slideViewDidTap(_ isSlideContentArea: Bool) {
        slideManager.updateSelectedContent(isFocused: isSlideContentArea)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return slideManager.slideCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .darkGray
        return cell
    }
}

extension ViewController: NavigatorDelegate {
    func addSlideButtonDidTap(_ sender: UIButton) {
        let slideView = SlideView()
        let squareSlideView = SquareContentView()
        slideView.setContentView(squareSlideView)
        slideView.delegate = self
        mainView.addSlideView(slideView)

        slideManager.createSquareContentSlide { [squareSlideView]  (squareContent) in
            let alpha = Double(squareContent.alpha.rawValue)
            let color = squareContent.color.uiColor
            let size = squareContent.size.cgSize
            squareSlideView.updateAlpha(alpha)
            squareSlideView.updateColor(color)
            squareSlideView.updateSize(size)
        }

        mainView.reloadNavigatorTableView()
    }
}

// MARK: - Model -> Controller -> View
extension ViewController {
    func addObserverForSlideContent() {
        NotificationCenter.default.addObserver(self, selector: #selector(slideContentColorDidChange(_:)), name: .Content.ColorDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(slideContentAlphaDidChange(_:)), name: .Content.AlphaDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(slideContentDidFocus(_:)), name: .Content.DidFocus, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(slideContentDidDefocus(_:)), name: .Content.DidDefocus, object: nil)
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
}
