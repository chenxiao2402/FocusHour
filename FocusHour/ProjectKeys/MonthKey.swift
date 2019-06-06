//
//  MonthEnum.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/2/18.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import Foundation

enum MonthKey: String {
    case Jan = "Jan"
    case Feb = "Feb"
    case Mar = "Mar"
    case Apr = "Apr"
    case May = "May"
    case Jun = "Jun"
    case Jul = "Jul"
    case Aug = "Aug"
    case Sep = "Sep"
    case Oct = "Oct"
    case Nov = "Nov"
    case Dec = "Dec"
}

extension MonthKey: CaseIterable {
    static func getKeyList() -> [MonthKey] {
        return MonthKey.allCases
    }
    
    func getNumber() -> Int {
        return MonthKey.getKeyList().firstIndex(of: self)! + 1
    }
    
    func translate() -> String {
        return LocalizationTool.translate(self.rawValue)
    }
}
