//
//  ViewController+FromView.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/26.
//

import UIKit
import OSLog

// MARK: InspectorView
extension ViewController {
    func configureDelegate() {
        colorPickerView.delegate = self
        mainView.configureDelegate(self)
    }
}

extension ViewController: InspectorDelegate {
    func alphaStepperValueDidChange(_ sender: UIStepper) {
        guard let smAlpha = SMAlpha(sender.value) else {
            Logger.track(message: "alpha to SMAlpha convert Error", type: .error)
            return
        }
        slideManager.updateSelectedContent(alpha: smAlpha)
    }

    func colorPickerButtonDidTap(_ sender: UIButton) {
        colorPickerView.modalPresentationStyle = .popover
        colorPickerView.modalTransitionStyle = .crossDissolve
        colorPickerView.popoverPresentationController?.sourceView = sender
        present(colorPickerView, animated: true)
    }
}

extension ViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        if !continuously {
            slideManager.updateSelectedContent(color: SMColor(color) ?? .white)
        }
    }
}

// MARK: SlideView
extension ViewController: SlideViewDelegate {
    func slideViewDidTap(_ isSlideContentArea: Bool) {
        slideManager.updateSelectedContent(isFocused: isSlideContentArea)
    }
}

// MARK: NavigatorView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return slideManager.slideCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .darkGray
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        slideManager.selectSlide(at: indexPath.row)
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        slideManager.moveSlide(at: sourceIndexPath.row, to: destinationIndexPath.row)
    }
}

extension ViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
}

extension ViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if session.localDragSession != nil {
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }

    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
    }
}

extension ViewController: NavigatorDelegate {
    func addSlideButtonDidTap(_ sender: UIButton) {
        slideManager.createSquareContentSlide()
    }
}
