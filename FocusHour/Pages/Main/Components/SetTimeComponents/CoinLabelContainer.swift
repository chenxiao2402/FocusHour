//
//  CoinLabelContainer.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/6/15.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

@IBDesignable
class CoinLabelContainer: UIView {

    @IBInspectable var radius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = radius > 0
        }
    }
    
}
