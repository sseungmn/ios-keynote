//
//  BackgroundColorChangeableButton.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/20.
//

import UIKit

class BackgroundColorChangeableButton: UIButton {

    override var backgroundColor: UIColor? {
        willSet {
            guard let newValue else { return }
            setTitleColor(newValue.complementaryColor(), for: .normal)
            setTitle(newValue.hexString, for: .normal)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    private func configureUI() {
        layer.cornerRadius = 5.0
        resetUI()
    }

    func resetUI() {
        backgroundColor = .systemGray4
        setTitle("", for: .normal)
    }
}
