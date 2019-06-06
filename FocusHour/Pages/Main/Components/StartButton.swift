//
//  CustomButton.swift
//  FocusHour
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
        self.setTitle(LocalizationKey.Start.translate(), for: .normal)
        UITool.setCustomButtonSize(self)
        
        layer.backgroundColor = ColorKey.Emerald.uiColor().cgColor
        layer.masksToBounds = false
        
        layer.borderWidth = 2.0;
        layer.borderColor = UIColor.clear.cgColor
        
        layer.shadowColor = ColorKey.ForestGreen.uiColor().cgColor
        layer.shadowOpacity = 1.0;
        layer.shadowOffset = CGSize(width: 0, height: 3)

        self.addTarget(self, action: #selector(StartButton.changeBackgroundColor), for: [.touchDown])
        self.addTarget(self, action: #selector(StartButton.resetBackgroundColor), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }
    
    @objc private func changeBackgroundColor() {
        layer.backgroundColor = ColorKey.DarkEmerald.uiColor().cgColor
    }
    
    @objc private func resetBackgroundColor() {
        layer.backgroundColor = ColorKey.Emerald.uiColor().cgColor
    }

}
