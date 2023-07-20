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
        
        let rectA = factory.create(of: SquareContentFactory.self)

        let rectView = UIView()
        rectView.frame.size = CGSize(width: rectA.content.side, height: rectA.content.side)
        rectView.center = mainView.center
        rectView.backgroundColor = rectA.content.color.uiColor
        mainView.addSubview(rectView)
        selectedSlide = rectA

        let tap = UITapGestureRecognizer()
        view.addGestureRecognizer(tap)
        tap.addTarget(self, action: #selector(viewDidTap))
    }

    @objc
    func viewDidTap() {
    }
}

// MARK: - View -> Controller -> Model
extension ViewController: StatusDelegate {
    func alphaStepperValueDidChange(_ sender: UIStepper) {
        guard let alpha = SMAlpha(sender.value) else {
            Logger.track(message: "alpha to SMAlpha convert Error", type: .error)
            return
        }
        if let content = selectedSlide?.content as? AlphaChangeable {
            content.alpha = alpha
        }
    }
    
    func colorPickerButtonDidTap(_ sender: UIButton) {
        present(colorPickerView, animated: true)
    }
}

extension ViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        if !continuously {
            mainView.configureColorStatus(color)
            if let content = selectedSlide?.content as? ColorChangeable {
                content.color = SMColor(color) ?? .white
            }
        }
    }
}

// MARK: - Model -> Controller -> View
