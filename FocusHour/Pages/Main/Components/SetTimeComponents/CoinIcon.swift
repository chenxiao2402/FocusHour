//
//  CoinIcon.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/6/15.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

@IBDesignable
class CoinIcon: UIImageView {

    @IBInspectable var zIndex: CGFloat = 0 {
        didSet {
            self.layer.zPosition = zIndex
        }
    }

}
