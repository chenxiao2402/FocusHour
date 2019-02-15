//
//  TimeTool.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/15.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import Foundation

class TimeTool {
    static func getCurrentTime() -> [Int] {
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        return [year, month, day]
    }
    
    static func getCurrentYear() -> Int {
        return getCurrentTime()[0]
    }
    
    static func getCurrentMonth() -> Int {
        return getCurrentTime()[1]
    }
    
    static func getCurrentDay() -> Int {
        return getCurrentTime()[2]
    }
}
