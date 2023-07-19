//
//  ViewController.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/17.
//

import UIKit
import OSLog

class ViewController: UIViewController {

    let factory = SlideFactory()

    private var slides = [Slide]()
    private var selectedSlide: Slide?

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

        let rectA = factory.create(name: "rectA", of: SquareSlide.self)

        let rectView = UIView()
        rectView.frame.size = rectA.size.cgSize
        rectView.center = mainView.center
        rectView.backgroundColor = rectA.color.uiColor
        mainView.addSubview(rectView)

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
        print(sender.value)
    }
    
    func colorPickerButtonDidTap(_ sender: UIButton) {
        present(colorPickerView, animated: true)
        colorPickerView.delegate = sender
    }
}

// MARK: - Model -> Controller -> View
