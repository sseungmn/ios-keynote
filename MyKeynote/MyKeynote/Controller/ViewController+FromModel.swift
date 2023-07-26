//
//  ViewController+FromModel.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/26.
//

import UIKit
import OSLog

extension ViewController {
    func addObserverForSlideContent() {
        NotificationCenter.default.addObserver(self, selector: #selector(slideContentColorDidChange(_:)), name: .Content.ColorDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(slideContentAlphaDidChange(_:)), name: .Content.AlphaDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(slideDidCreate(_:)), name: .Slide.DidCreate, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(slideDidSelect(_:)), name: .Slide.DidSelect, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(slideDidDeselect(_:)), name: .Slide.DidDeselect, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(slideContentDidFocus(_:)), name: .Content.DidFocus, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(slideContentDidDefocus(_:)), name: .Content.DidDefocus, object: nil)
    }

    @objc
    func slideContentColorDidChange(_ notification: Notification) {
        guard let smColor = notification.userInfo?["color"] as? SMColor else {
            Logger.track(message: "Notification Object conversion Error", type: .error)
            return
        }
        let color = smColor.uiColor
        colorPickerView.selectedColor = color
        mainView.updateSelectedContentInspector(color: color)
        mainView.updateSelectedContentView(color: color)

        let initialAlpha = Double(SMAlpha.max.rawValue)
        mainView.updateSelectedContentView(alpha: initialAlpha)
        mainView.updateSelectedContentInspector(alpha: initialAlpha)
    }

    @objc
    func slideContentAlphaDidChange(_ notification: Notification) {
        guard let smAlpha = notification.userInfo?["alpha"] as? SMAlpha else {
            Logger.track(message: "Notification Object conversion Error", type: .error)
            return
        }
        let alpha = Double(smAlpha.rawValue)
        mainView.updateSelectedContentInspector(alpha: alpha)
        mainView.updateSelectedContentView(alpha: alpha / 10.0)
    }



    @objc
    func slideDidCreate(_ notification: Notification) {
        guard let slide = notification.userInfo?["slide"] as? Slide,
              let content = slide.content as? SquareContent
        else {
            Logger.track(message: "Notification Object conversion Error", type: .error)
            return
        }

        let contentView = SquareContentView()
        let slideView = SlideView(contentView: contentView)
        slideView.delegate = self
        mainView.addSlideView(slideView)
        mainView.reloadNavigatorTableView()
        mainView.selectNavigatorTableView(at: slideManager.slideCount - 1)

        contentView.updateSize(content.size.cgSize)
        contentView.updateAlpha(content.alpha.cgFloat)
        contentView.updateColor(content.color.uiColor)
    }

    @objc
    func slideDidSelect(_ notification: Notification) {
        guard let index = notification.userInfo?["index"] as? Int else {
            Logger.track(message: "Notification Object conversion Error", type: .error)
            return
        }
        mainView.selectSlideView(at: index)
    }

    @objc
    func slideDidDeselect(_ notification: Notification) {
        mainView.deselectSlideView()
    }

    @objc
    func slideContentDidFocus(_ notification: Notification) {
        mainView.focusSelectedContentView()
        if let smColor = notification.userInfo?["color"] as? SMColor {
            let color = smColor.uiColor
            mainView.updateSelectedContentView(color: color)
            mainView.updateSelectedContentInspector(color: color)
        }
        if let smAlpha = notification.userInfo?["alpha"] as? SMAlpha {
            let alpha = Double(smAlpha.rawValue)
            mainView.updateSelectedContentView(alpha: alpha)
            mainView.updateSelectedContentInspector(alpha: alpha)
        }
    }

    @objc
    func slideContentDidDefocus(_ notification: Notification) {
        mainView.defocusContentView()
        mainView.disenableAlphaInspector()
        mainView.disenableColorInspector()
    }
}
