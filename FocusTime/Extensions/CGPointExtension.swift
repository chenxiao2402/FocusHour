//
//  CGPointExtension.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/6.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

extension CGPoint {
    func distance(to target: CGPoint) -> CGFloat {
        return sqrt(pow(self.x - target.x, 2) + pow(self.y - target.y, 2))
    }
    
    // 计算这个点在整个圆形slider中转过的角度（0 ～ 360）
    // 起始点是圆心的正上方，角度按照顺时针计算
    // 因为和正常的坐标系的0度的点不一样，所以sin和cos的计算方法不一样
    func getAngle(circleCenter: CGPoint) -> CGFloat {
        let sin = (self.x - circleCenter.x) / self.distance(to: circleCenter)
        let cos = (circleCenter.y - self.y) / self.distance(to: circleCenter)
        let TWO_PI: CGFloat = CGFloat(2 * Double.pi)
        let angle = sin>=0 ? acos(cos) : TWO_PI - acos(cos)
        return angle
    }
}
