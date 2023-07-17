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

        let rectA = Slide(name: "rectA", width: 245, color: SMColor(red: 10, green: 50, blue: 80), alpha: .five)
        let rectB = Slide(name: "rectB", width: 245, color: SMColor(red: 10, green: 50, blue: 80), alpha: .five)
        let rectC = Slide(name: "rectC", width: 245, color: SMColor(red: 10, green: 50, blue: 80), alpha: .five)
        let rectD = Slide(name: "rectD", width: 245, color: SMColor(red: 10, green: 50, blue: 80), alpha: .five)
        print(rectA)
        print(rectB)
        print(rectC)
        print(rectD)
    }
}

