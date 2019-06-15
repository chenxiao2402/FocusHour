//
//  SystemKey.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/6/12.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

struct SystemConstant {
    static let MonthAchievementMinueRange = [0, 60, 300, 600, 1200, 2400]
    static let AchievementSeriesName = "Achievement"
    
    static let FocusCountdownRange = [0, 5, 10, 30, 60, 90, 120]
    static let FocusRecordRange = [0, 10, 30, 60, 90, 120]
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
}

