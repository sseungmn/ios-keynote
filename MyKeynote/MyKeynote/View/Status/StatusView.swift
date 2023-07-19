//
//  StatusView.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/19.
//

import UIKit
import OSLog

protocol StatusDelegate {

    func colorPickerButtonDidTap(_ sender: UIButton)
    func alphaStepperValueDidChange(_ sender: UIStepper)
}

final class StatusView: UIView {

    // TODO: TitledContainer로 분리해 TitleLabel 프로퍼티 없애기
    private let backgroundColorTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "배경색"
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()

    private let colorPickerButton = BackgroundColorChangeableButton()

    private let alphaTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "투명도"
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()

    private let alphaStepper = ValuePresentableStepper(
        minValue: Double(SMAlpha.min.rawValue),
        maxValue: Double(SMAlpha.max.rawValue),
        stepValue: Double(SMAlpha.stepValue)
    )

    var delegate: StatusDelegate?

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
        addSubview(alphaStepper)

        colorPickerButton.addTarget(self, action: #selector(colorPickerButtonDidTap(_:)), for: .touchUpInside)
        alphaStepper.addTarget(self, action: #selector(alphaStepperValueDidChange(_:)), for: .valueChanged)
    }

    @objc
    private func colorPickerButtonDidTap(_ sender: UIButton) {
        Logger.track()
        delegate?.colorPickerButtonDidTap(sender)
    }

    @objc
    private func alphaStepperValueDidChange(_ sender: UIStepper) {
        Logger.track()
        delegate?.alphaStepperValueDidChange(sender)
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
        alphaStepper.frame.origin = CGPoint(x: inset, y: minY)
        alphaStepper.frame.size.width = frame.width - inset
        alphaStepper.configureLayout()
    }
}

extension StatusView {
    func configureDelegate<T: StatusDelegate>(_ delegator: T) {
        delegate = delegator
    }
}

extension UIButton: UIColorPickerViewControllerDelegate {
    public func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        backgroundColor = color
    }
}
