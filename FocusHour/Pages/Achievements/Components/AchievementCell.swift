//
//  AchievementCell.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/6/7.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class AchievementCell: IconCell {
    var month: Int!
    
    func drawCell(focusMinute: Int, text: String) {
        self.icon = getImage(ByFocusMinutePerMonth: focusMinute)
        self.text = text
        setNeedsDisplay()
    }
    
    func getImage(ByFocusMinutePerMonth minute: Int) -> UIImage? {
        let range = [0, 60, 300, 600, 1200, 2400, 3600]
        let imageList = ["level0-baretree", "level1-bonsai", "level2-bamboo", "level3-tree", "level4-trees", "level5-woods", "level6-forest"]
        return UIImage(named: ImageTool.getTableDrivenImage(ofTime: minute, timeRange: range, imageList: imageList))
    }
}
