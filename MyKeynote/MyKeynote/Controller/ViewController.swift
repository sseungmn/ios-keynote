//
//  ViewController.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/17.
//

import UIKit
import OSLog

class ViewController: UIViewController {

    let logger = Logger()
    let factory = SlideFactory()

    override func viewDidLoad() {
        super.viewDidLoad()

//        let rectA = SquareSlide(name: "rectA", using: &generator)
//        let rectB = SquareSlide(name: "rectB", using: &generator)
//        let rectC = SquareSlide(name: "rectC", using: &generator)
//        let rectD = SquareSlide(name: "rectD", using: &generator)
        let rectA = factory.create(name: "rectA", of: SquareSlide.self)
        let rectB = factory.create(name: "rectB", of: SquareSlide.self)
        let rectC = factory.create(name: "rectC", of: SquareSlide.self)
        let rectD = factory.create(name: "rectD", of: SquareSlide.self)
        logger.log("\(rectA.description)")
        logger.log("\(rectB.description)")
        logger.log("\(rectC.description)")
        logger.log("\(rectD.description)")
    }
}

struct MockRandomNumberGenerator: RandomNumberGenerator {
    func next() -> UInt64 {
        // 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00010000
        return UInt64(1)//6)
    }
}
