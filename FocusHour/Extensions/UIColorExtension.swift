//
//  UIColorExtension.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/6/16.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue, alpha)
    }
}
