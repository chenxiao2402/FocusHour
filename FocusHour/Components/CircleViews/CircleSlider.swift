//
//  CircleTimeSetter.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/2/8.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class CircleSlider: CircleView {
    var circleBorderWidth: CGFloat = 0.0
    var ThumbNormalRadius: CGFloat = 0.0
    var ThumbTouchedRadius: CGFloat = 0.0
    var thumbRadius: CGFloat = 0.0
    var thumbView = UIView()  // slider上的那个滑块（小圆点）
    var alphaAngle: CGFloat = 0.0 { // 移动点相对于起始点顺时针扫过的角度(弧度)
        didSet {
            remainingMinutes = Int(alphaAngle / TWO_PI * 120.0)
        }
    }
    
    override func setup() {
        super.setup()
        alphaAngle = TEN_MIN_ANGLE
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
        thumbView.backgroundColor = ColorKey.AppleGreen.uiColor()
        thumbView.isUserInteractionEnabled = false //不加这一句的话，小圆点会盖住下面的UIView，导致CircleSlider.touchesMoved失效..
        iconView.isUserInteractionEnabled = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        thumbRadius = ThumbTouchedRadius
        redrawComponent(touch: touches.first!)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        thumbRadius = ThumbTouchedRadius
        redrawComponent(touch: touches.first!)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        thumbRadius = ThumbNormalRadius
        redrawComponent(touch: touches.first!)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        thumbRadius = ThumbNormalRadius
        redrawComponent(touch: touches.first!)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let ctx = UIGraphicsGetCurrentContext();
        // 设置背景，画一个空的圆环
        ctx?.setFillColor(ColorKey.LightYellow.uiColor().cgColor)
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
        
        drawIconView(getImageBy(remainingMinutes: remainingMinutes))
        drawThumbView()
        drawHeadLabel(LocalizationKey.SetTimeTitle.translate())
        drawFootLabel(timeFormat(), isTime: true)
    }
    
    func drawThumbView() {
        // 计算移动点的位置，alphaAngle = 移动点相对于起始点顺时针扫过的角度(弧度)
        // x = r * sin(alpha) + 圆心的x坐标, sin在0-PI之间为正，PI-2*PI之间为负
        // y = r * cos(alpha) + 圆心的y坐标
        let x: CGFloat = drawCenter.x + radius * CGFloat(sin(alphaAngle))
        let y: CGFloat = drawCenter.y - radius * CGFloat(cos(alphaAngle))
        currentPoint = CGPoint(x: x, y: y)
        
        thumbView.removeFromSuperview()
        thumbView.frame = CGRect(x: 0, y: 0, width: thumbRadius * 2, height: thumbRadius * 2)
        thumbView.layer.cornerRadius = thumbRadius
        thumbView.center = currentPoint
        addSubview(thumbView)
    }
    
    private func redrawComponent(touch: UITouch) {
        let touchPoint: CGPoint = touch.location(in: self)
        // 如果点击点和currentPoint（thumbView所在的位置）的距离在50以内，重新设置角度，并且重画
        // 如果距离在50以上，并且小圆点的半径设置是normal（这意味着Touch结束），则仍然要重画（把现在视图中的Touched半径重画为Normal）
        // 如果我在拖动小圆点的时候，手指离开它的距离超过50，则小圆点不再响应，但是一旦移回距离50以内，又能继续响应
        if (touchPoint.distance(to: currentPoint) <= 50) {
            let angle = touchPoint.getAngle(circleCenter: drawCenter)
            if (alphaAngle < HALF_PI && angle > TWO_PI - HALF_PI) {
                alphaAngle = TEN_MIN_ANGLE
            } else if (alphaAngle > TWO_PI - HALF_PI && angle < HALF_PI){
                alphaAngle = TWO_PI
            } else {
                alphaAngle = max(TEN_MIN_ANGLE, angle)
            }
            setNeedsDisplay()
        } else if (thumbRadius == ThumbNormalRadius) {
            setNeedsDisplay()
        }
    }
}
