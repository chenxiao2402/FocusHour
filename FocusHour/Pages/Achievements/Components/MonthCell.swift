//
//  AchievementCell.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/6/7.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class MonthCell: IconCell {
    
    var month: Int!
    
    func drawCell(focusMinute: Int, text: String) {
        self.icon = getImage(ByFocusMinutePerMonth: focusMinute)
        self.text = text
        setNeedsDisplay()
    }
    
    func getImage(ByFocusMinutePerMonth minute: Int) -> UIImage? {
        let range = SystemConstant.MonthAchievementMinueRange
        let series = "Achievement"
        return UIImage(named: "\(series)-\(ImageTool.getIndex(focusMinutes: minute, timeRange: range) + 1)")
    }
}
