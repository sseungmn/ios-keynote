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

    let slideManager: SlideManager

    private var mainView: MainView {
        return view as? MainView ?? MainView()
    }

    private let colorPickerView = UIColorPickerViewController()

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

        colorPickerView.delegate = self
        colorPickerView.supportsAlpha = false

        addObserverForSlideContent()
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
        view.addGestureRecognizer(tap)
    }

    @objc
    func viewDidTap() {
        let slideView = SlideView(frame: .zero)
        mainView.addSlideView(slideView)

        let rectView = SquareContentView()
        slideView.setContentView(rectView)
        rectView.frame.size = CGSize(width: 100, height: 100)
        rectView.center = CGPoint(x: slideView.frame.width / 2 , y: slideView.frame.height / 2)
        rectView.select()

        let rectA = slideManager.createSlide(of: .square)
    }
}

// MARK: - View -> Controller -> Model
extension ViewController: StatusDelegate {
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

// MARK: - Model -> Controller -> View
extension ViewController {
    func addObserverForSlideContent() {
        NotificationCenter.default.addObserver(self, selector: #selector(slideContentColorDidChange(_:)), name: .ContentColorDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(slideContentAlphaDidChange(_:)), name: .ContentAlphaDidChange, object: nil)
    }

    @objc
    func slideContentColorDidChange(_ notification: Notification) {
        guard let rawColor = (notification.object as? ColorChangeable)?.color.uiColor else {
            Logger.track(message: "Notification Object conversion Error", type: .error)
            return
        }
        let vividColor = rawColor.withAlphaComponent(1.0)
        colorPickerView.selectedColor = vividColor
        mainView.updateSelectedSlideStatus(color: vividColor)
        mainView.updateSelectedSlideContentView(color: rawColor)
    }

    @objc
    func slideContentAlphaDidChange(_ notification: Notification) {
        guard let smAlpha = (notification.object as? AlphaChangeable)?.alpha else {
            Logger.track(message: "Notification Object conversion Error", type: .error)
            return
        }
        let alpha = Double(smAlpha.rawValue)
        mainView.updateSelectedSlideStatus(alpha: alpha)
        mainView.updateSelectedSlideContentView(alpha: alpha / 10.0)
    }
}
