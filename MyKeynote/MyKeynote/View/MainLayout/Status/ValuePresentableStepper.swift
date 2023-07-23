//
//  ValuePresentableStepper.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/19.
//

import UIKit
import OSLog

final class ValuePresentableStepper: UIView {

    private let valueLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .right
        label.backgroundColor = .white
        return label
    }()

    private let stepper = UIStepper()

    private let inset: CGFloat = 5
    private let spacing: CGFloat = 5
    private let labelInset: CGFloat = 5


    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }

    private func configureUI() {
        addSubview(valueLabel)
        addSubview(stepper)
    }

    private func setValueLabelText(_ text: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.tailIndent = -inset
        paragraphStyle.alignment = .right

        valueLabel.attributedText = NSAttributedString(
            string: "\(text)",
            attributes: [.paragraphStyle: paragraphStyle]
        )
    }
}

extension ValuePresentableStepper: LayoutConfigurable {
    func configureLayout() {
        stepper.frame.origin.x = frame.width - inset - stepper.frame.width

        valueLabel.frame.origin.x = inset
        valueLabel.frame.size.width = stepper.frame.minX - spacing - inset
        valueLabel.frame.size.height = stepper.frame.height

        frame.size.height = stepper.frame.height
    }
}

// MARK: - API

// MARK: Setting
extension ValuePresentableStepper {
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        stepper.addTarget(target, action: action, for: controlEvents)
    }
    
    func settingValueRange(min: Double, max: Double, step: Double) {
        stepper.minimumValue = min
        stepper.maximumValue = max
        stepper.stepValue = step
    }
}

// MARK: Update
extension ValuePresentableStepper {
    func updateValue(_ value: Double) {
        setValueLabelText("\(value)")
        stepper.value = value
    }
}
