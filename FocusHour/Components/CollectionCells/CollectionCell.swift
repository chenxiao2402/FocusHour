//
//  CollectionViewCell.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/2/18.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class CollectionnCell: UICollectionViewCell {
    
    static let ratio: CGFloat = 1.1
    let TWO_PI: CGFloat = CGFloat(2 * Double.pi)
    var radius: CGFloat = 0.0           //半径
    var drawCenter: CGPoint!       //绘制圆的圆心
    var iconView = UIImageView()  // 绘制的图像（奖杯/植物），位于圆形的中间
    var footLabel = UILabel()  // 展示你设置的文字，位于圆形的下方
    var icon: UIImage!  // 在iconView中要画的图像
    var text: String!  // footLabel中的文字
    
    override func draw(_ rect: CGRect) {
        drawCenter = CGPoint(x: frame.size.width / 2.0, y: frame.size.width / 2.0)
        radius = frame.size.width / 2.0 * 0.8
    }
    
    func drawIconView(ratio: CGFloat) {
        iconView.removeFromSuperview()
        iconView.frame = CGRect(x: 0, y: 0, width: radius * ratio, height: radius * ratio)
        iconView.image = icon
        iconView.center = drawCenter
        addSubview(iconView)
    }
    
    func drawFootLabel(color: UIColor) {
        footLabel.removeFromSuperview()
        let fontSize: CGFloat = UIDevice().model == "iPad" ? 24.0 : 18.0
        footLabel.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: fontSize * 1.2)
        footLabel.text = text
        footLabel.font = UIFont(name: "Verdana", size: fontSize)
        footLabel.textAlignment = NSTextAlignment.center
        footLabel.textColor = color
        footLabel.center = CGPoint(x: frame.size.width / 2.0, y: frame.size.width)
        addSubview(footLabel)
    }
    
    func drawCell(icon: UIImage?, text: String) {
        self.icon = icon
        self.text = text
        setNeedsDisplay()
    }
}

