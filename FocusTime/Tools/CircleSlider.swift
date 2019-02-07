//
//  CircleSlider.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/6.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

enum ThumbRadius: CGFloat {
    case Normal = 15.0
    case Touched = 18.0
}

class CircleSlider: UIView {
    private let TWO_PI: CGFloat = CGFloat(2 * Double.pi)
    private let HALF_PI: CGFloat = CGFloat(Double.pi / 2)
    private let circleBorderWidth: CGFloat = 18.0
    private let sliderBackgroundColor: UIColor = UIColor.lightGray
    private let sliderProgressColor: UIColor = UIColor.blue

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
    
    var thumbRadius: CGFloat = ThumbRadius.Normal.rawValue
    
    private var thumbView = UIView()  // slider上的那个滑块（小圆点）
    private var iconView = UIImageView() // 展示你要“种植”的植物的区域，位于圆形slider中间
    private var timeLabel = UILabel() // 展示你设置的时间，位于圆形slider的下方
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.backgroundColor = UIColor.green
        thumbView.backgroundColor = UIColor.red
        thumbView.isUserInteractionEnabled = false //不加这一句的话，小圆点会盖住下面的UIView，导致CircleSlider.touchesMoved失效..
        iconView.isUserInteractionEnabled = false
    }
    
    private func drawIconView() {
        iconView.removeFromSuperview()
        iconView.frame = CGRect(x: 0, y: 0, width: radius * 1.2, height: radius * 1.2)
        iconView.image = getImageBy(time: focusMinutes)
        iconView.center = drawCenter
        addSubview(iconView)
    }
    
    private func drawThumbView() {
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
    
    private func drawTimeLabel() {
        timeLabel.removeFromSuperview()
        let fontSize = frame.size.height * 0.12
        timeLabel.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: fontSize)
        timeLabel.text = "\(focusMinutes):00"
        timeLabel.font = UIFont(name: "Verdana", size: fontSize)
        timeLabel.textAlignment = NSTextAlignment.center
        timeLabel.textColor = UIColor.white
        timeLabel.center = CGPoint(x: frame.size.width / 2.0, y: frame.size.height - fontSize / 2)
        addSubview(timeLabel)
    }

    override func draw(_ rect: CGRect) {
        drawCenter = CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0)
        radius = frame.size.width / 2.0 * 0.9
        
        let ctx = UIGraphicsGetCurrentContext();
        // 设置背景，画一个空的圆环
        ctx?.setFillColor(UIColor(red: 255/255.0, green: 255/255.0, blue: 224/255.0, alpha: 1.0).cgColor)
        ctx?.setShouldAntialias(true)
        ctx?.setStrokeColor(sliderBackgroundColor.cgColor)
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
        ctx?.setStrokeColor(sliderProgressColor.cgColor);
        ctx?.addPath(circlePath.cgPath);
        ctx?.drawPath(using: CGPathDrawingMode.stroke)
        ctx?.restoreGState()
        
        drawIconView()
        drawThumbView()
        drawTimeLabel()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        thumbRadius = ThumbRadius.Touched.rawValue
        redrawComponent(touch: touches.first!)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        thumbRadius = ThumbRadius.Touched.rawValue
        redrawComponent(touch: touches.first!)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        thumbRadius = ThumbRadius.Normal.rawValue
        redrawComponent(touch: touches.first!)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        thumbRadius = ThumbRadius.Normal.rawValue
        redrawComponent(touch: touches.first!)
    }
    
    private func redrawComponent(touch: UITouch) {
        let touchPoint: CGPoint = touch.location(in: self)
        // 如果点击点和currentPoint（thumbView所在的位置）的距离在50以内，重新设置角度，并且重画
        // 如果距离在50以上，并且小圆点的半径设置是normal（这意味着Touch结束），则仍然要重画（把现在视图中的Touched半径重画为Normal）
        // 如果我在拖动小圆点的时候，手指离开它的距离超过50，则小圆点不再响应，但是一旦移回距离50以内，又能继续响应
        if (touchPoint.distance(to: currentPoint) <= 50) {
            let angle = touchPoint.getAngle(circleCenter: drawCenter)
            if (alphaAngle < HALF_PI && angle > TWO_PI - HALF_PI) {
                alphaAngle = 0
            } else if (alphaAngle > TWO_PI - HALF_PI && angle < HALF_PI){
                alphaAngle = TWO_PI
            } else {
                alphaAngle = angle
            }
            setNeedsDisplay()
        } else if (thumbRadius == ThumbRadius.Normal.rawValue) {
            setNeedsDisplay()
        }
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
