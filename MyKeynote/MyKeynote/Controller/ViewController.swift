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

    private var mainView: MainView {
        return view as? MainView ?? MainView()
    }

    override func loadView() {
        super.loadView()

        let mainView = MainView()
        mainView.frame = view.frame
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
