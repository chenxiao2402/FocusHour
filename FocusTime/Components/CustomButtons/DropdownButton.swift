//
//  DropdownButton.swift
//  FocusTime
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
        backgroundColor = ColorEnum.getColor(name: .DarkSlateGray)
        titleLabel?.font = UIFont(name: "Verdana", size: 20)
        
        addTarget(self, action: #selector(DropdownButton.changeBackgroundColor), for: [.touchDown])
        addTarget(self, action: #selector(DropdownButton.resetBackgroundColor), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }
    
    @objc private func changeBackgroundColor() {
        backgroundColor = ColorEnum.getColor(name: .DarkSlateGray_Touched)
    }
    
    @objc private func resetBackgroundColor() {
        backgroundColor = ColorEnum.getColor(name: .DarkSlateGray)
    }
    
}
