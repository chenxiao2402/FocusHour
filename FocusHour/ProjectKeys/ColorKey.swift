//
//  ColorEnum.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/2/8.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

enum ColorKey {
    case LightYellow
    case GrassGreen
    case LightKhaki
    case LightKhaki_Transparent
    case AppleGreen
    case ForestGreen
    case Emerald
    case DarkEmerald
    case PaleGreen
    case LightGreen
    case DimGray
    case DarkMask
    
    case DarkTheme
    case LightThemeOne
    case LightThemeTwo
    case LightThemeThree
    case LightThemeFour
    case LightThemeFive
}

extension ColorKey {
    func uiColor() -> UIColor {
        switch self {
        case .LightYellow:
            return #colorLiteral(red: 0.9999002814, green: 1, blue: 0.8651396632, alpha: 1)
        case .GrassGreen:
            return #colorLiteral(red: 0.6, green: 0.9019607843, blue: 0.3019607843, alpha: 1)
        case .LightKhaki:
            return #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.5490196078, alpha: 1)
        case .LightKhaki_Transparent:
            return #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.5490196078, alpha: 0.2)
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
        case .DarkMask:
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)
        case .DarkTheme:
            return #colorLiteral(red: 0.1098039216, green: 0.1098039216, blue: 0.1098039216, alpha: 0.799416738)
        case .LightThemeOne:
            return #colorLiteral(red: 0.1764705882, green: 0.262745098, blue: 0.2666666667, alpha: 1)
        case .LightThemeTwo:
            return #colorLiteral(red: 0.07843137255, green: 0.2823529412, blue: 0.3921568627, alpha: 1)
        case .LightThemeThree:
            return #colorLiteral(red: 0.1647058824, green: 0.2274509804, blue: 0.5411764706, alpha: 1)
        case .LightThemeFour:
            return #colorLiteral(red: 0.2156862745, green: 0.1843137255, blue: 0.368627451, alpha: 1)
        case .LightThemeFive:
            return #colorLiteral(red: 0.1882352941, green: 0.2941176471, blue: 0.462745098, alpha: 1)
        }
    }
}
