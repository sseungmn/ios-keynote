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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let rectA = factory.create(name: "rectA", of: SquareSlide.self)
        Logger.main.log("\(rectA.description)")

        let rectView = UIView()
        rectView.frame.size = rectA.size.cgSize
        rectView.center = view.center
        rectView.backgroundColor = rectA.color.uiColor
        view.addSubview(rectView)
    }
}
