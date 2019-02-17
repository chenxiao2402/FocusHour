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
    case AppleGreen
    case ForestGreen
    case Emerald
    case DarkEmerald
    case PaleGreen
    case LightGreen
    case DimGray
    case DarkSlateGray
}

extension ColorEnum {
    static func getColor(name colorName: ColorEnum) -> UIColor {
        switch colorName {
        case .LightYellow:
            return #colorLiteral(red: 0.9999002814, green: 1, blue: 0.8651396632, alpha: 1)
        case .GrassGreen:
            return #colorLiteral(red: 0.6, green: 0.9019607843, blue: 0.3019607843, alpha: 1)
        case .LightKhaki:
            return #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.5490196078, alpha: 1)
        case .AppleGreen:
            return #colorLiteral(red: 0.5490196078, green: 0.9019607843, blue: 0, alpha: 1)
        case .ForestGreen:
            return #colorLiteral(red: 0.1333333333, green: 0.5450980392, blue: 0.1333333333, alpha: 1)
        case .Emerald:
            return #colorLiteral(red: 0.3137254902, green: 0.7843137255, blue: 0.4705882353, alpha: 1)
        case .DarkEmerald:
            return #colorLiteral(red: 0.3137254902, green: 0.7843137255, blue: 0.4705882353, alpha: 0.6044252997)
        case .PaleGreen:
            return #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        case .LightGreen:
            return #colorLiteral(red: 0.8, green: 0.9764705882, blue: 0.6705882353, alpha: 1)
        case .DimGray:
            return #colorLiteral(red: 0.2509803922, green: 0.2509803922, blue: 0.2509803922, alpha: 1)
        case .DarkSlateGray:
            return #colorLiteral(red: 0.1843137255, green: 0.3098039216, blue: 0.3098039216, alpha: 1)
        }
    }
}
