//
//  CircleSlider.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/6.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

enum ThumbRadius: CGFloat {
    case Normal = 10.0
    case Touched = 12.0
}

class CircleSlider: UIView {
    private let TWO_PI: CGFloat = CGFloat(2 * Double.pi)
    private let HALF_PI: CGFloat = CGFloat(Double.pi / 2)
    private let circleBorderWidth: CGFloat = 5.0
    private let sliderBackgroundColor: UIColor = UIColor.lightGray
    private let sliderProgressColor: UIColor = UIColor.blue

    var radius: CGFloat = 0.0           //半径
    var drawCenter: CGPoint!       //绘制圆的圆心
    var startPoint: CGPoint! //thumb起始位置
    var currentPoint: CGPoint!        //滑块目前所在的位置
    var alphaAngle: CGFloat = 0.0            // 移动点相对于起始点顺时针扫过的角度(弧度)
    var loadProgress: CGFloat = 0.0
    
    var thumbRadius: CGFloat = ThumbRadius.Normal.rawValue
    var interaction: Bool = true
    
    private var thumbView = UIView()  // slider上的那个滑块（小圆点）
    private var iconView = UIImageView() //展示你要“种植”的植物的区域，位于圆形slider中间
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        print("Set up running")
        backgroundColor = UIColor(red: 255.0/255, green: 255.0/255, blue: 224.0/255, alpha: 1.0)
        drawCenter = CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0)
        radius = 120.0
        loadProgress = 0.75
        alphaAngle = loadProgress * TWO_PI
        thumbView.backgroundColor = UIColor.red
        thumbView.isUserInteractionEnabled = false //不加这一句的话，小圆点会盖住下面的UIView，导致CircleSlider.touchesMoved失效..
        iconView.isUserInteractionEnabled = false
    }
    
    private func drawIconView() {
        iconView.removeFromSuperview()
        iconView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        iconView.image = getImageBy(time: loadProgress * 120)
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

    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext();
        // 设置背景，画一个空的圆环
        ctx?.setFillColor(UIColor.clear.cgColor)
        ctx?.setShouldAntialias(true)
        ctx?.setStrokeColor(sliderBackgroundColor.cgColor)
        ctx?.setLineWidth(circleBorderWidth)
        ctx?.addArc(center: drawCenter, radius: radius, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: false)
        ctx?.drawPath(using: CGPathDrawingMode.fillStroke)
        
        // 根据进度条的数值画相应的slider长度
        let circlePath: UIBezierPath = UIBezierPath()
        let startAngle: CGFloat = CGFloat(-Double.pi / 2)
        let currentAngle: CGFloat = startAngle + CGFloat(2 * Double.pi) * loadProgress;
        circlePath.addArc(withCenter: drawCenter, radius: radius, startAngle: startAngle, endAngle: currentAngle, clockwise: true)
        ctx?.saveGState()
        ctx?.setShouldAntialias(true)
        ctx?.setLineWidth(circleBorderWidth)
        ctx?.setStrokeColor(sliderProgressColor.cgColor);
        ctx?.addPath(circlePath.cgPath);
        ctx?.drawPath(using: CGPathDrawingMode.fillStroke)
        ctx?.restoreGState()
        
        drawIconView()
        drawThumbView()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan ran")
        super.touchesBegan(touches, with: event)
        interaction = true
        thumbRadius = ThumbRadius.Touched.rawValue
        redrawComponent(touch: touches.first!)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesMoved ran")
        super.touchesMoved(touches, with: event)
        thumbRadius = ThumbRadius.Touched.rawValue
        redrawComponent(touch: touches.first!)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesEnded ran")
        super.touchesEnded(touches, with: event)
        thumbRadius = ThumbRadius.Normal.rawValue
        redrawComponent(touch: touches.first!)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesCancelled ran")
        super.touchesCancelled(touches, with: event)
        thumbRadius = ThumbRadius.Normal.rawValue
        redrawComponent(touch: touches.first!)
    }
    
    private func redrawComponent(touch: UITouch) {
        if (interaction) {
            let touchPoint: CGPoint = touch.location(in: self)
            
            //如果点击点和currentPoint（thumbView所在的位置）的距离大于30，不做操作。
            if (touchPoint.distance(to: currentPoint) > 30) {
                interaction = false
                print("distance > 30")
                return
            }
            
            let angle = touchPoint.getAngle(circleCenter: drawCenter)
            if (alphaAngle < HALF_PI && angle > TWO_PI - HALF_PI) {
                alphaAngle = 0
            } else if (alphaAngle > TWO_PI - HALF_PI && angle < HALF_PI){
                alphaAngle = TWO_PI
            } else {
                alphaAngle = angle
            }

            loadProgress = alphaAngle / TWO_PI
            
            setNeedsDisplay()
        }
    }
}

extension CircleSlider {
    func getImageBy(time: CGFloat) -> UIImage? {
        let timeRange = [0, 20, 50, 80, 110]
        let imageList = ["level1-leaves", "level2-grass", "level3-flower", "level4-tree", "level5-forest"]
        
        var imageName = imageList[0]
        for (i, timeBoundry) in timeRange.enumerated() {
            if (time >= CGFloat(timeBoundry)) {
                imageName = imageList[i]
            }
        }
        return UIImage(named: imageName)
    }
}
