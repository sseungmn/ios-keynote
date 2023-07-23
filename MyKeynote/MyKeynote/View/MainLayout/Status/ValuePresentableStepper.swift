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

    init(minValue: Double, maxValue: Double, stepValue: Double) {
        super.init(frame: .zero)
        stepper.minimumValue = minValue
        stepper.maximumValue = maxValue
        stepper.stepValue = stepValue
        stepper.value = (minValue + maxValue) / 2
        setValueLabelText("\(stepper.value)")
        configureUI()
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
        addSubview(valueLabel)
        addSubview(stepper)

        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
    }

    @objc private func stepperValueChanged(_ sender: UIStepper) {
        Logger.track()
        setValueLabelText("\(sender.value)")
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

extension ValuePresentableStepper {
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        stepper.addTarget(target, action: action, for: controlEvents)
    }
}
