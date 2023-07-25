//
//  SquareContentView.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/24.
//

import UIKit

final class SquareContentView: ContentViewProtocol, ViewColorChangeable {

    /// 0.0일 때 완전 투명, 1.0일 때 완전 불투명
    var contentAlpha: CGFloat = 1.0
    var contentColor: UIColor = .white
    var borderColor: UIColor = .black
}
