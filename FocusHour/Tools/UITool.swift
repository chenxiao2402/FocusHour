//
//  File.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/2/10.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class UITool {
    static func setCustomButtonSize(_ button: UIButton) {
        switch UIDevice().model {
        case "iPad":
            button.frame.size = CGSize(width: 180, height: 75)
            button.layer.cornerRadius = 25.0
            button.titleLabel?.font = UIFont(name: "Verdana", size: 22)
        default:
            button.frame.size = CGSize(width: 132, height: 55)
            button.layer.cornerRadius = 15.0
            button.titleLabel?.font = UIFont(name: "Verdana", size: 16)
        }
        button.widthAnchor.constraint(equalToConstant: button.frame.size.width).isActive = true
        button.heightAnchor.constraint(equalToConstant: button.frame.size.height).isActive = true
    }
    
    static func setToolButtonSize(_ button: UIButton, ratio: Double) {
        switch UIDevice().model {
        case "iPad":
            button.frame.size = CGSize(width: 48, height: 48 * ratio)
        default:
            button.frame.size = CGSize(width: 36, height: 36 * ratio)
        }
        button.widthAnchor.constraint(equalToConstant: button.frame.size.width).isActive = true
        button.heightAnchor.constraint(equalToConstant: button.frame.size.height).isActive = true
    }
    
    static func setBackgroundImage(_ view: UIView, random: Bool) {
        if view is UITableView {
            let tableView = view as! UITableView
            let imageView = UIImageView.init(frame: view.bounds)
            imageView.image = getBackgroundImage(random: random)
            tableView.backgroundView = imageView
        } else {
            UIGraphicsBeginImageContext(view.frame.size)
            getBackgroundImage(random: random)?.draw(in: view.bounds)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            view.backgroundColor = UIColor.init(patternImage: image!)
        }
    }
    
    static func isScreenLocked() -> Bool{
        // 除了锁屏之外，用户把亮度调到最低，brightness也是0...
        // 网上说可以操作UIScreen.main.brightness来检测是否是锁屏
        // 但是对于brightness的操作能够改变亮度，但是不能改变这个值本身（WTF），但是下一次加载的时候brightness值会改变...
        // 然而上述对于brightness的操作app打开时只能进行一次，之后的更改都会没有效果（WTF）
        // 所以写成下面这样，虽然不完美，但是大多数时候能正常运行...
        return UIScreen.main.brightness == 0.0
    }
}

extension UITool {
    private static func getBackgroundImage(random: Bool) -> UIImage? {
        if !random {
            return UIImage(named: "base-background")
        } else {
            let index = Int.random(in: 0..<8)
            return UIImage(named: "background-\(index)")
        }
    }
}
