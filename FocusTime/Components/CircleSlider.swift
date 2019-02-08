//
//  CircleSlider.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/6.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class CircleSlider: UIView {
    let TWO_PI: CGFloat = CGFloat(2 * Double.pi)
    let HALF_PI: CGFloat = CGFloat(Double.pi / 2)
    let TEN_MIN_ANGLE: CGFloat = CGFloat(Double.pi / 6)
    let SLIDER_BACKGROUND_COLOR: UIColor = ColorEnum.getColor(name: .LightKhaki)
    let SLIDER_PROGRESS_COLOR: UIColor = ColorEnum.getColor(name: .GrassGreen)
    var circleBorderWidth: CGFloat = 0.0
    var ThumbNormalRadius: CGFloat = 0.0
    var ThumbTouchedRadius: CGFloat = 0.0
    var thumbRadius: CGFloat = 0.0
    
    var radius: CGFloat = 0.0           //半径
    var drawCenter: CGPoint!       //绘制圆的圆心
    var currentPoint: CGPoint!        //滑块目前所在的位置

    
    var alphaAngle: CGFloat = 0.0 { // 移动点相对于起始点顺时针扫过的角度(弧度)
        didSet {
            loadProgress = alphaAngle / TWO_PI
            focusMinutes = Int(loadProgress * 120.0)
        }
    }
    var loadProgress: CGFloat = 0.0
    var focusMinutes: Int = 0
    
    var thumbView = UIView()  // slider上的那个滑块（小圆点）
    var iconView = UIImageView() // 展示你要“种植”的植物的区域，位于圆形slider中间
    var timeLabel = UILabel() // 展示你设置的时间，位于圆形slider的下方
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        switch UIDevice().model {
        case "iPad":
            circleBorderWidth = 18.0
            ThumbNormalRadius = 18.0
            ThumbTouchedRadius = 24.0
        default:
            circleBorderWidth = 12.0
            ThumbNormalRadius = 12.0
            ThumbTouchedRadius = 15.0
        }
        thumbRadius = ThumbNormalRadius
    }
    
    func drawIconView() {
        preconditionFailure("Func drawIconView must be overridden")
    }
    
    func drawThumbView() {
        preconditionFailure("Func drawThumbView must be overridden")
    }
    
    func drawTimeLabel() {
        preconditionFailure("Func drawTimeLabel must be overridden")
    }

    override func draw(_ rect: CGRect) {
        drawCenter = CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0)
        radius = frame.size.width / 2.0 * 0.9
        
        let ctx = UIGraphicsGetCurrentContext();
        // 设置背景，画一个空的圆环
        ctx?.setFillColor(ColorEnum.getColor(name: .LightYellow).cgColor)
        ctx?.setShouldAntialias(true)
        ctx?.setStrokeColor(SLIDER_BACKGROUND_COLOR.cgColor)
        ctx?.setLineWidth(circleBorderWidth)
        ctx?.addArc(center: drawCenter, radius: radius, startAngle: 0, endAngle: TWO_PI, clockwise: true)
        ctx?.drawPath(using: CGPathDrawingMode.fillStroke)
        
        // 根据进度条的数值画相应的slider长度
        let circlePath: UIBezierPath = UIBezierPath()
        let startAngle: CGFloat = -HALF_PI
        let currentAngle: CGFloat = startAngle + alphaAngle
        circlePath.addArc(withCenter: drawCenter, radius: radius, startAngle: startAngle, endAngle: currentAngle, clockwise: true)
        ctx?.saveGState()
        ctx?.setShouldAntialias(true)
        ctx?.setLineWidth(circleBorderWidth)
        ctx?.setStrokeColor(SLIDER_PROGRESS_COLOR.cgColor);
        ctx?.addPath(circlePath.cgPath);
        ctx?.drawPath(using: CGPathDrawingMode.stroke)
        ctx?.restoreGState()
        
        drawIconView()
        drawThumbView()
        drawTimeLabel()
    }
}

extension CircleSlider {
    func getImageBy(time: Int) -> UIImage? {
        let timeRange = [0, 20, 50, 80, 110]
        let imageList = ["level1-leaves", "level2-grass", "level3-bamboo", "level4-tree", "level5-forest"]
        
        var imageName = imageList[0]
        for (i, timeBoundry) in timeRange.enumerated() {
            if (time >= timeBoundry) {
                imageName = imageList[i]
            }
        }
        return UIImage(named: imageName)
    }
}
