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

    var mainView: MainView {
        return view as? MainView ?? MainView()
    }

    let colorPickerView: UIColorPickerViewController = {
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
        mainView.settingStepperValueRange(min: Double(SMAlpha.min.rawValue), max: Double(SMAlpha.max.rawValue) , step: 1.0)
        view = mainView
    }

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        mainView.configureLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        settingDelegate()
        registerCell()
        addObserverForSlideContent()
    }
}
