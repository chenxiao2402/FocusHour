//
//  CustomButton.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/8.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class StartButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButtonStyle()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setButtonStyle()
    }
    
    private func setButtonStyle() {
        layer.backgroundColor = ColorEnum.getColor(name: .Emerald).cgColor
        layer.masksToBounds = false
        layer.cornerRadius = 20.0
        
        layer.borderWidth = 2.0;
        layer.borderColor = UIColor.clear.cgColor
        
        layer.shadowColor = ColorEnum.getColor(name: .ForestGreen).cgColor
        layer.shadowOpacity = 1.0;
        layer.shadowOffset = CGSize(width: 0, height: 3)

        self.addTarget(self, action: #selector(StartButton.changeBackgroundColor), for: [.touchDown])
        self.addTarget(self, action: #selector(StartButton.resetBackgroundColor), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }
    
    @objc private func changeBackgroundColor() {
        layer.backgroundColor = ColorEnum.getColor(name: .DarkEmerald).cgColor
    }
    
    @objc private func resetBackgroundColor() {
        layer.backgroundColor = ColorEnum.getColor(name: .Emerald).cgColor
    }

}
