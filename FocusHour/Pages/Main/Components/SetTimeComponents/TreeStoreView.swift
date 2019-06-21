//
//  ForestStoreView.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/6/17.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

@IBDesignable
class TreeStoreView: UITableView {

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
            layer.borderColor = ColorKey.LightKhaki.uiColor().cgColor
        }
    }
    
    @IBInspectable var borderRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = borderRadius
            layer.masksToBounds = borderRadius > 0
        }
    }

    override func awakeFromNib() {
        backgroundColor = ColorKey.LightYellow.uiColor()
    }
}
