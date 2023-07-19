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

    override func viewDidLoad() {
        super.viewDidLoad()

        let rectA = factory.create(name: "rectA", of: SquareSlide.self)
        Logger.main.log("\(rectA.description)")

        let rectView = UIView()
        rectView.frame.size = rectA.size.cgSize
        rectView.center = mainView.center
        rectView.backgroundColor = rectA.color.uiColor
        mainView.addSubview(rectView)
        mainView.configureLayout()

        let tap = UITapGestureRecognizer()
        view.addGestureRecognizer(tap)
        tap.addTarget(self, action: #selector(viewDidTap))
    }

    @objc
    func viewDidTap() {
    }
}
