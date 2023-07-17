//
//  ViewController.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/17.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var generator: RandomNumberGenerator = MockRandomNumberGenerator()
        let rectA = Slide(name: "rectA", using: &generator)
        let rectB = Slide(name: "rectB", using: &generator)
        let rectC = Slide(name: "rectC", using: &generator)
        let rectD = Slide(name: "rectD", using: &generator)
        print(rectA)
        print(rectB)
        print(rectC)
        print(rectD)
    }
}

struct MockRandomNumberGenerator: RandomNumberGenerator {
    func next() -> UInt64 {
        return UInt64(1)
    }
}
