//
//  CollectionViewCell.swift
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
class CollectionViewCell: UICollectionViewCell {
    
    static let ratio: CGFloat = 1.1
    
    let TWO_PI: CGFloat = CGFloat(2 * Double.pi)
    var radius: CGFloat = 0.0           //半径
    var drawCenter: CGPoint!       //绘制圆的圆心
    var iconView = UIImageView()  // 绘制的图像（奖杯/植物），位于圆形的中间
    var footLabel = UILabel()  // 展示你设置的文字，位于圆形的下方
    var icon: UIImage!  // 在iconView中要画的图像
    var text: String!  // footLabel中的文字
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let circleBorderWidth: CGFloat = 5.0
        drawCenter = CGPoint(x: frame.size.width / 2.0, y: frame.size.width / 2.0)
        radius = frame.size.width / 2.0 * 0.8
        
        let ctx = UIGraphicsGetCurrentContext();
        // 设置背景，画一个空的圆环
        ctx?.setFillColor(ColorEnum.getColor(name: .LightYellow).cgColor)
        ctx?.setShouldAntialias(true)
        ctx?.setStrokeColor(UIColor.white.cgColor)
        ctx?.setLineWidth(circleBorderWidth)
        ctx?.addArc(center: drawCenter, radius: radius, startAngle: 0, endAngle: TWO_PI, clockwise: true)
        ctx?.drawPath(using: CGPathDrawingMode.stroke)
        
        drawIconView()
        drawFootLabel()
    }
    
    private func drawIconView() {
        iconView.removeFromSuperview()
        iconView.frame = CGRect(x: 0, y: 0, width: radius * 1.2, height: radius * 1.2)
        iconView.image = icon
        iconView.center = drawCenter
        addSubview(iconView)
    }
    
    private func drawFootLabel() {
        footLabel.removeFromSuperview()
        let fontSize: CGFloat = UIDevice().model == "iPad" ? 28.0 : 20.0
        footLabel.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: fontSize * 1.2)
        footLabel.text = text
        footLabel.font = UIFont(name: "Verdana", size: fontSize)
        footLabel.textAlignment = NSTextAlignment.center
        footLabel.textColor = UIColor.white
        footLabel.center = CGPoint(x: frame.size.width / 2.0, y: frame.size.width)
        addSubview(footLabel)
    }
    
    func drawCell(icon: UIImage?, text: String) {
        self.icon = icon
        self.text = text
        setNeedsDisplay()
    }
}
