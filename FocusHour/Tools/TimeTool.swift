//
//  TimeTool.swift
//  FocusHour
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
    
    static func minuteFormat(of minute: Int) -> String{
        let hour = minute / 60
        return hour > 0 ? "\(hour)\(LocalizationKey.Hour.translate())" : "\(minute)\(LocalizationKey.Minute.translate())"
    }
    
    static func dateFormat(month: Int, day: Int) -> String{
        let localizedMonth = MonthKey.getMonth(fromNumber: month)!.translate()
        guard let systemLanguage = LanguageKey.systemLanguage() else {
            return "\(month)-\(day)"
        }
        switch systemLanguage {
        case LanguageKey.English:
            return "\(localizedMonth) \(day)"
        case LanguageKey.Chinese:
            return "\(localizedMonth)\(day)日"
        case LanguageKey.Japanese:
            return "\(localizedMonth)\(day)日"
        }
    }
}
