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
    
    func resetTime() {
        remainingTime -= 1
        focusTime += 1
    }
    
    override func draw(_ rect: CGRect) {
        drawCenter = CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0)
        radius = frame.size.width / 2.0 * 0.9
        
        let ctx = UIGraphicsGetCurrentContext();
        // 设置背景，画一个空的圆环
        ctx?.setFillColor(ColorEnum.getColor(name: .LightYellow).cgColor)
        ctx?.setShouldAntialias(true)
        ctx?.setStrokeColor(SLIDER_BACKGROUND_COLOR.cgColor)
        ctx?.setLineWidth(0)
        ctx?.addArc(center: drawCenter, radius: radius, startAngle: 0, endAngle: TWO_PI, clockwise: true)
        ctx?.drawPath(using: CGPathDrawingMode.fillStroke)
        
        drawIconView(minutes: focusTime / 60)
        drawTimeLabel()
    }
}

