//
//  TreeIcon.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/6/17.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

@IBDesignable
class TreeIcon: UIView {

    @IBInspectable var imageRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = imageRadius
            layer.masksToBounds = imageRadius > 0
        }
    }

    override func awakeFromNib() {
        backgroundColor = ColorKey.LightKhaki_Transparent.uiColor()
        layer.shadowColor = backgroundColor?.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 0, height: 3)
    }
}
