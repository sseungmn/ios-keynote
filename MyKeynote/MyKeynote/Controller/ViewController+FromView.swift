//
//  ViewController+FromView.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/26.
//

import UIKit
import OSLog

extension ViewController {
    func settingDelegate() {
        // Navigator
        mainView.settingNavigatorViewDelegate(self)
        mainView.settingNavigatorTableViewDelegate(self)
        mainView.settingNavigatorTableViewDataSource(self)
        mainView.settingNavigatorTableViewDragNDropDelegate(self)

        // Inspector
        colorPickerView.delegate = self
        mainView.settingInspectorViewDelegate(self)
    }

    func registerCell() {
        mainView.registerNavigatorTableViewCell(
            SlideNavigatorTableViewCell.self,
            forCellReuseIdentifier: SlideNavigatorTableViewCell.identifier
        )
    }
}

// MARK: InspectorView
extension ViewController: InspectorViewDelegate {
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
        present(colorPickerView, animated: false)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SlideNavigatorTableViewCell.intrinsicContentHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SlideNavigatorTableViewCell.identifier, for: indexPath) as? SlideNavigatorTableViewCell else {
            Logger.track(message: "Cell 변환 실패")
            return SlideNavigatorTableViewCell()
        }
        cell.frame.size.width = tableView.frame.width
        cell.frame.size.height = SlideNavigatorTableViewCell.intrinsicContentHeight
        cell.configure(title: "\(indexPath.row + 1)", image: UIImage(systemName: "rectangle.inset.filled"))
        cell.configureLayout()
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let oldIndexPath = tableView.indexPathForSelectedRow {
            if oldIndexPath == indexPath {
                mainView.deselectNavigatorTableView(at: indexPath.row)
                return nil
            } else {
                return indexPath
            }
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        slideManager.selectSlide(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        slideManager.deselectSlide()
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard sourceIndexPath != destinationIndexPath else { return }
        slideManager.moveSlide(at: sourceIndexPath.row, to: destinationIndexPath.row)
        mainView.reloadNavigatorTableView()
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

extension ViewController: NavigatorViewDelegate {
    func addSlideButtonDidTap(_ sender: UIButton) {
        slideManager.createSquareContentSlide()
    }
}
