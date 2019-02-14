//
//  CircleSlider.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/6.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class CircleView: UIView {
    let TWO_PI: CGFloat = CGFloat(2 * Double.pi)
    let HALF_PI: CGFloat = CGFloat(Double.pi / 2)
    let TEN_MIN_ANGLE: CGFloat = CGFloat(Double.pi / 6)
    let TEN_MIN: Int = 600
    let SLIDER_BACKGROUND_COLOR: UIColor = ColorEnum.getColor(name: .LightKhaki)
    let SLIDER_PROGRESS_COLOR: UIColor = ColorEnum.getColor(name: .GrassGreen)
    
    var radius: CGFloat = 0.0           //半径
    var drawCenter: CGPoint!       //绘制圆的圆心
    var currentPoint: CGPoint!        //滑块目前所在的位置

    var remainingMinutes: Int = 0
    var remainingSeconds: Int = 0
    
    var iconView = UIImageView() // 展示你要“种植”的植物的区域，位于圆形slider中间
    var headLabel = UILabel() // 展示提示信息，位于圆形slider的上方
    var footLabel = UILabel() // 展示你设置的时间，位于圆形slider的下方
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func draw(_ rect: CGRect) {
        drawCenter = CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0)
        radius = frame.size.width / 2.0 * 0.9
    }
    
    func setup() {
        self.backgroundColor = UIColor.clear
    }
    
    func drawIconView(_ image: UIImage?) {
        iconView.removeFromSuperview()
        iconView.frame = CGRect(x: 0, y: 0, width: radius * 1.2, height: radius * 1.2)
        iconView.image = image
        iconView.center = drawCenter
        addSubview(iconView)
    }
    
    func drawHeadLabel(_ text: String) {
        headLabel.removeFromSuperview()
        let fontSize: CGFloat = UIDevice().model == "iPad" ? 40.0 : 28.0
        headLabel.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height * 0.2)
        headLabel.text = text
        headLabel.font = UIFont(name: "Verdana-Bold", size: fontSize)
        headLabel.textAlignment = NSTextAlignment.center
        headLabel.textColor = UIColor.white
        headLabel.center = CGPoint(x: frame.size.width / 2.0, y: headLabel.frame.size.height / 2)
        addSubview(headLabel)
    }
    
    func drawFootLabel(_ text: String, isTime: Bool) {
        footLabel.removeFromSuperview()
        let deviceFontSize: CGFloat = UIDevice().model == "iPad" ? 32.0 : 24.0
        let fontSize: CGFloat = isTime ? frame.size.height * 0.12 : deviceFontSize
        footLabel.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: fontSize * 1.2)
        footLabel.text = text
        footLabel.font = UIFont(name: "Verdana", size: fontSize)
        footLabel.textAlignment = NSTextAlignment.center
        footLabel.textColor = UIColor.white
        footLabel.center = CGPoint(x: frame.size.width / 2.0, y: frame.size.height * 0.9)
        addSubview(footLabel)
    }
}

extension CircleView {
    func getImageBy(minutes time: Int) -> UIImage? {
        let timeRange = [0, 3, 6, 10, 25, 50, 75, 100, 120]
        let imageList = ["grow-bud", "grow-leaf", "grow-plant", "level1-bonsai", "level2-bamboo", "level3-tree", "level4-trees", "level5-woods", "level6-forest"]
        
        var imageName = imageList[0]
        for (i, timeBoundry) in timeRange.enumerated() {
            if (time >= timeBoundry) {
                imageName = imageList[i]
            }
        }
        return UIImage(named: imageName)
    }
    
    func timeFormat() -> String {
        let minuteFormat = remainingMinutes >= 10 ? "\(remainingMinutes)" : "0\(remainingMinutes)"
        let secondFormat = remainingSeconds >= 10 ? "\(remainingSeconds)" : "0\(remainingSeconds)"
        return "\(minuteFormat):\(secondFormat)"
    }
}
