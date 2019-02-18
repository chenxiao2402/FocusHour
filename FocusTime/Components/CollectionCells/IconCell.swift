//
//  IconCell.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/18.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

/*
 这个cell用于成就界面的子界面，显示某个月份中的记录（包括种下的植物和专注的时间）
 */
class IconCell: CollectionnCell {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // 设置背景，画一个空的圆环
        let strokeColor = ColorEnum.getColor(name: .LightYellow)
        let ctx = UIGraphicsGetCurrentContext();
        ctx?.setFillColor(strokeColor.cgColor)
        ctx?.setShouldAntialias(true)
        ctx?.addArc(center: drawCenter, radius: radius, startAngle: 0, endAngle: TWO_PI, clockwise: true)
        ctx?.drawPath(using: CGPathDrawingMode.fill)
        
        drawIconView()
        drawFootLabel(color: strokeColor)
    }
}
