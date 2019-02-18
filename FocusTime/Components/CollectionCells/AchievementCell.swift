//
//  AchievementCell.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/17.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

/*
 这个cell用于成就界面，显示月份或者某个月份当中的某个奖励
 为了渲染的效果，这个cell的宽高比为4:5
 */
class AchievementCell: CollectionnCell {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // 设置背景，画一个空的圆环
        let strokeColor = UIColor.white
        let circleBorderWidth: CGFloat = 5.0
        let ctx = UIGraphicsGetCurrentContext();
        ctx?.setFillColor(ColorEnum.getColor(name: .LightYellow).cgColor)
        ctx?.setShouldAntialias(true)
        ctx?.setStrokeColor(strokeColor.cgColor)
        ctx?.setLineWidth(circleBorderWidth)
        ctx?.addArc(center: drawCenter, radius: radius, startAngle: 0, endAngle: TWO_PI, clockwise: true)
        ctx?.drawPath(using: CGPathDrawingMode.stroke)
        
        drawIconView()
        drawFootLabel(color: strokeColor)
    }
}
