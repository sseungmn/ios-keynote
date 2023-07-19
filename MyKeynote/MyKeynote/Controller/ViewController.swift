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

        let rectA = factory.create(name: "rectA", of: SquareSlide.self)
        let rectB = factory.create(name: "rectB", of: SquareSlide.self)
        let rectC = factory.create(name: "rectC", of: SquareSlide.self)
        let rectD = factory.create(name: "rectD", of: SquareSlide.self)
        Logger.main.log("\(rectA.description)")
        Logger.main.log("\(rectB.description)")
        Logger.main.log("\(rectC.description)")
        Logger.main.log("\(rectD.description)")
    }
}
