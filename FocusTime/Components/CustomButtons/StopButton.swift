//
//  StopButton.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/9.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class StopButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButtonStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setButtonStyle()
    }
    
    func setButtonStyle() {
        setTitle(LocalizationKey.Giveup.translate(), for: .normal)
        UITool.setCustomButtonSize(self)
        
        layer.backgroundColor = UIColor.clear.cgColor
        layer.masksToBounds = true
        layer.cornerRadius = 20.0
        
        layer.borderWidth = 2.0;
        layer.borderColor = UIColor.white.cgColor
        
        self.addTarget(self, action: #selector(StopButton.changeBackgroundColor), for: [.touchDown])
        self.addTarget(self, action: #selector(StopButton.resetBackgroundColor), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }
    
    @objc private func changeBackgroundColor() {
        layer.opacity = 0.5
    }
    
    @objc private func resetBackgroundColor() {
        layer.opacity = 1.0
    }
    
}
