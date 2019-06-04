//
//  PreferenceTool.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/6/4.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import Foundation

class ModeTool {
    static func switchMode(ofName mode: AppMode) {
        UserDefaults.standard.set(!isMode(ofName: mode), forKey: mode.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func isMode(ofName mode: AppMode) -> Bool {
        guard let modeActivated = UserDefaults.standard.object(forKey: mode.rawValue) as? Bool else {
            UserDefaults.standard.set(false, forKey: mode.rawValue)
            return false
        }
        return modeActivated
    }
    
}

enum AppMode: String {
    case WorkingMode = "WorkingMode"
    case NightMode = "NightMode"
}
