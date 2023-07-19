//
//  StatusView.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/19.
//

import UIKit

final class StatusView: UIView {

    // TODO: TitledContainer로 분리해 TitleLabel 프로퍼티 없애기
    private let backgroundColorTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "배경색"
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()

    private let colorPickerButton: UIButton = {
        var button = UIButton()
        button.setTitle("0xFFCC00", for: .normal)
        button.setTitleColor(.systemYellow.complementaryColor(), for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 5.0
        return button
    }()

    private let alphaTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "투명도"
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()

    private let alphaValuePresentableStepper = ValuePresentableStepper(
        minValue: Double(SMAlpha.min.rawValue),
        maxValue: Double(SMAlpha.max.rawValue),
        stepValue: Double(SMAlpha.stepValue)
    )

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }

    private func configureUI() {
        backgroundColor = .systemGray5

        addSubview(backgroundColorTitleLabel)
        addSubview(colorPickerButton)
        addSubview(alphaTitleLabel)
        addSubview(alphaValuePresentableStepper)

        colorPickerButton.addTarget(self, action: #selector(colorPickerButtonDidTap(_:)), for: .touchUpInside)
    }

    @objc
    private func colorPickerButtonDidTap(_ sender: UIButton) {
        print("Hello")
    }
}

extension StatusView: LayoutConfigurable {
    func configureLayout() {
        let inset: CGFloat = 5
        let spacing: CGFloat = 10

        backgroundColorTitleLabel.frame.origin = CGPoint(x: inset, y: inset)
        backgroundColorTitleLabel.sizeToFit()

        colorPickerButton.frame.origin = CGPoint(x: inset, y: backgroundColorTitleLabel.frame.maxY + spacing)
        colorPickerButton.frame.size = CGSize(width: frame.width - 2 * inset, height: 40)

        alphaTitleLabel.frame.origin = CGPoint(x: inset, y: colorPickerButton.frame.maxY + 2 * spacing)
        alphaTitleLabel.sizeToFit()

        let minY = alphaTitleLabel.frame.maxY + spacing
        alphaValuePresentableStepper.frame.origin = CGPoint(x: inset, y: minY)
        alphaValuePresentableStepper.frame.size.width = frame.width - inset
        alphaValuePresentableStepper.configureLayout()
    }
}
