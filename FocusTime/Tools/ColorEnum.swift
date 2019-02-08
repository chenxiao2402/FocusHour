//
//  ColorEnum.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/8.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

enum ColorEnum {
    case LightYellow
    case GrassGreen
    case LightKhaki
    case DarkGrassGreen
}

extension ColorEnum {
    static func getColor(name colorName: ColorEnum) -> UIColor {
        switch colorName {
        case .LightYellow:
            return UIColor(red: 255/255.0, green: 255/255.0, blue: 224/255.0, alpha: 1.0)
        case .GrassGreen:
            return UIColor(red: 153/255.0, green: 230/255.0, blue: 77/255.0, alpha: 1.0)
        case .LightKhaki:
            return UIColor(red: 245/255.0, green: 245/255.0, blue: 140/255.0, alpha: 1.0)
        case .DarkGrassGreen:
            return UIColor(red: 145/255.0, green: 220/255.0, blue: 70/255.0, alpha: 1.0)
        }
    }
}
