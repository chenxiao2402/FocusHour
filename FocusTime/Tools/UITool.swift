//
//  File.swift
//  FocusTime
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
            button.titleLabel?.font = UIFont(name: "Verdana", size: 24)
        default:
            button.frame.size = CGSize(width: 120, height: 50)
            button.layer.cornerRadius = 15.0
            button.titleLabel?.font = UIFont(name: "Verdana", size: 18)
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
        UIGraphicsBeginImageContext(view.frame.size)
        getBackgroundImage(random: random)?.draw(in: view.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        view.backgroundColor = UIColor.init(patternImage: image!)
    }
}

extension UITool {
    private static func getBackgroundImage(random: Bool) -> UIImage? {
        if !random {
            return UIImage(named: "background-0")
        } else {
            let imageNum = 8
            let index = Int(arc4random()) % imageNum
            return UIImage(named: "background-\(index)")
        }
    }
}
