//
//  PaddingLabel.swift
//  ExerciseGuide
//
//  Created by 이인호 on 11/19/24.
//

import UIKit

class PaddingLabel: UILabel {
    var textInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10) // 패딩 설정

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + textInsets.left + textInsets.right,
                      height: size.height + textInsets.top + textInsets.bottom)
    }
}
