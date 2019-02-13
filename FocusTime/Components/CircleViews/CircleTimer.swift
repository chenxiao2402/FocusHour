//
//  CircleTimeCounter.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/9.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class CircleTimer: CircleView {
    var focusTime: Int = 0  // How long you have focused
    var remainingTime: Int = 0 {  // The remainging time that you need to focus, calculated by SECONDS
        didSet {
            remainingMinutes = remainingTime / 60
            remainingSeconds = remainingTime % 60
            setNeedsDisplay()
        }
    }
    
    override func setup() {
        super.setup()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let ctx = UIGraphicsGetCurrentContext();
        // 设置背景，画一个空的圆环
        ctx?.setFillColor(ColorEnum.getColor(name: .LightYellow).cgColor)
        ctx?.setShouldAntialias(true)
        ctx?.setStrokeColor(SLIDER_BACKGROUND_COLOR.cgColor)
        ctx?.setLineWidth(0)
        ctx?.addArc(center: drawCenter, radius: radius, startAngle: 0, endAngle: TWO_PI, clockwise: true)
        ctx?.drawPath(using: CGPathDrawingMode.fillStroke)
        
        drawIconView(getImageBy(minutes: focusTime / 60))
        drawHeadLabel(LocalizationKey.CountdownTitle.translate())
        drawFootLabel(timeFormat(), isTime: true)
    }
    
    func resetTime() {
        remainingTime -= 1
        focusTime += 1
    }
    
    func end() {
        if remainingTime <= 0 {
            drawHeadLabel(LocalizationKey.NotificationSuccess.translate())
            drawFootLabel(LocalizationKey.Congratulations.translate(), isTime: false)
        } else if treeHasGrownUp() {
            drawHeadLabel(LocalizationKey.NotificationSuccess.translate())
            drawFootLabel(LocalizationKey.YouCanDoBetter.translate(), isTime: false)
        } else {
            drawIconView(UIImage(named: "bare-tree"))
            drawHeadLabel(LocalizationKey.NotificationDeath.translate())
            drawFootLabel(LocalizationKey.Encouragement.translate(), isTime: false)
        }
    }
}

extension CircleTimer {
    func treeHasGrownUp() -> Bool {
        return focusTime > 6
    }
}

