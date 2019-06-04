//
//  PreferenceTool.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/6/4.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import Foundation

class PreferenceTool {
    static let workingModekey = "isWorkingMode"
    
    static func switchWorkingMode() {
        UserDefaults.standard.set(!isWorkingMode(), forKey: workingModekey)
        UserDefaults.standard.synchronize()
    }
    
    static func isWorkingMode() -> Bool {
        guard let isWorkingMode = UserDefaults.standard.object(forKey: workingModekey) as? Bool else {
            UserDefaults.standard.set(false, forKey: workingModekey)
            return false
        }
        return isWorkingMode
    }
    
}
