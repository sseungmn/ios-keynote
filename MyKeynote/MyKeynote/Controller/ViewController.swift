//
//  ViewController.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/17.
//

import UIKit
import OSLog

//protocol SelectedSlide {
//    func selectedSlideAlphaDidChange()
//    func selectedSlideColorDidChange()
//}

class ViewController: UIViewController {

    let factory = SlideFactory()

    private var slides = [any Slidable]()
    private var selectedSlide: (any Slidable)?
    private var selectedContent: SlideContent?

    private var mainView: MainView {
        return view as? MainView ?? MainView()
    }

    private let colorPickerView = UIColorPickerViewController()

    override func loadView() {
        super.loadView()

        let mainView = MainView()
        mainView.frame = view.frame
        mainView.configureDelegate(self)
        view = mainView
    }

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        mainView.configureLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        colorPickerView.delegate = self
        colorPickerView.supportsAlpha = false

        addObserverForSlideContent()
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
        view.addGestureRecognizer(tap)
    }

    @objc
    func viewDidTap() {
        let rectA = factory.create(of: SquareContentFactory.self)

        let slideView = SlideView(frame: .zero)
        mainView.addSlideView(slideView)

        let rectView = SquareContentView()
        slideView.setContentView(rectView)
        rectView.frame.size = CGSize(width: rectA.content.side, height: rectA.content.side)
        rectView.center = CGPoint(x: slideView.frame.width / 2 , y: slideView.frame.height / 2)
        rectView.select()
        selectedSlide = rectA
        selectedContent = rectA.content
    }
}

// MARK: - View -> Controller -> Model
extension ViewController: StatusDelegate {
    func alphaStepperValueDidChange(_ sender: UIStepper) {
        guard let smAlpha = SMAlpha(sender.value) else {
            Logger.track(message: "alpha to SMAlpha convert Error", type: .error)
            return
        }
        if let content = selectedContent as? AlphaChangeable {
            content.alpha = smAlpha
        }
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
            if let content = selectedContent as? ColorChangeable {
                content.color = SMColor(color) ?? .white
            }
        }
    }
}

// MARK: - Model -> Controller -> View
extension ViewController {
    func addObserverForSlideContent() {
        NotificationCenter.default.addObserver(self, selector: #selector(slideContentColorDidChange(_:)), name: .ContentColorDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(slideContentAlphaDidChange(_:)), name: .ContentAlphaDidChange, object: nil)
    }

    @objc
    func slideContentColorDidChange(_ notification: Notification) {
        guard let color = (notification.object as? ColorChangeable)?.color.uiColor else {
            Logger.track(message: "Notification Object conversion Error", type: .error)
            return
        }
        mainView.updateSelectedSlideStatus(color: color)
        mainView.updateSelectedSlideContentView(color: color)
    }

    @objc
    func slideContentAlphaDidChange(_ notification: Notification) {
        guard let smAlpha = (notification.object as? AlphaChangeable)?.alpha else {
            Logger.track(message: "Notification Object conversion Error", type: .error)
            return
        }
        let alpha = Double(smAlpha.rawValue) / 10.0
        mainView.updateSelectedSlideStatus(alpha: alpha)
        mainView.updateSelectedSlideContentView(alpha: alpha)
    }
}
