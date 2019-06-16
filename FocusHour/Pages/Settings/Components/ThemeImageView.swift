//
//  CustomImageView.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/6/16.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

@IBDesignable
class ThemeImageView: UIImageView {

    @IBInspectable var imageBorderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = imageBorderWidth
            layer.borderColor = UIColor.white.cgColor
        }
    }
    
    @IBInspectable var imageRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = imageRadius
            layer.masksToBounds = imageRadius > 0
        }
    }

}
