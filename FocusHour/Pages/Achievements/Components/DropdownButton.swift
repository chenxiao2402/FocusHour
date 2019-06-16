//
//  DropdownButton.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/2/18.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class DropdownButton: UIButton {
    @IBInspectable var buttonSize: CGSize = CGSize(width: 300, height: 50)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButtonStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setButtonStyle()
    }
    
    private func setButtonStyle() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: buttonSize.height).isActive = true
        widthAnchor.constraint(equalToConstant: buttonSize.width).isActive = true
        backgroundColor = Theme.getCurrentTheme().themeColor
        titleLabel?.font = UIFont(name: "Verdana", size: 20)

        addTarget(self, action: #selector(DropdownButton.changeBackgroundColor), for: [.touchDown])
        addTarget(self, action: #selector(DropdownButton.resetBackgroundColor), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }
    
    @objc private func changeBackgroundColor() {
        let rgba = Theme.getCurrentTheme().themeColor.cgColor.components!
        backgroundColor = UIColor(red: rgba[0] * 0.8, green: rgba[1] * 0.8, blue: rgba[2] * 0.8, alpha: rgba[3])
    }
    
    @objc private func resetBackgroundColor() {
        backgroundColor = Theme.getCurrentTheme().themeColor
    }
}
