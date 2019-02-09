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
    let SLIDER_BACKGROUND_COLOR: UIColor = ColorEnum.getColor(name: .LightKhaki)
    let SLIDER_PROGRESS_COLOR: UIColor = ColorEnum.getColor(name: .GrassGreen)
    
    var radius: CGFloat = 0.0           //半径
    var drawCenter: CGPoint!       //绘制圆的圆心
    var currentPoint: CGPoint!        //滑块目前所在的位置

    var remainingMinutes: Int = 0
    var remainingSeconds: Int = 0
    
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
        self.backgroundColor = UIColor.clear
    }
    
    func drawIconView(minutes: Int) {
        iconView.removeFromSuperview()
        iconView.frame = CGRect(x: 0, y: 0, width: radius * 1.2, height: radius * 1.2)
        iconView.image = getImageBy(minutes: minutes)
        iconView.center = drawCenter
        addSubview(iconView)
    }
    
    func drawTimeLabel() {
        timeLabel.removeFromSuperview()
        let fontSize = frame.size.height * 0.12
        timeLabel.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: fontSize)
        timeLabel.text = timeFormat()
        timeLabel.font = UIFont(name: "Verdana", size: fontSize)
        timeLabel.textAlignment = NSTextAlignment.center
        timeLabel.textColor = UIColor.white
        timeLabel.center = CGPoint(x: frame.size.width / 2.0, y: frame.size.height - fontSize / 2)
        addSubview(timeLabel)
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
